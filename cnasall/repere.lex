%{
#define HASH_TABLE_SIZE 251
#define BOOLEAN char
#define UNSIGNED_BYTE unsigned char
#define SIGNED_BYTE signed char
#define TRUE 1
#define FALSE 0
#define DEBUG_PROMPT "\n%DEBUG:" 

typedef struct{
char name[32];
int page;
int dest;
int children;
} command_type;
command_type cur_command;
int curpart=0, curchapter=0, cursection=0, cursubsection=0, cursubsubsection=0;
char lastpart[32]="", lastchapter[32]="", lastsection[32]="", lastsubsection[32]="";
int requested_page = 0, requested_dest = 792, requested_children = 0;
char bigbuffer[4096]="";

BOOLEAN debug = FALSE;

typedef struct hash_list *hash_list_pointer;
struct hash_list{
command_type command;
hash_list_pointer link;};
hash_list_pointer hash_table[HASH_TABLE_SIZE];

void hash_insert(command_type);
unsigned int hash(char*);
void look_in_hash(char[]);
void setchildren(char[],int);
void setvalues(command_type);

%}

%x FIRSTPASS
%x SECONDPASS
%x HASH_INPUTX
%x READ_PAGE
%x READ_DEST
%x IGNOREX
%x READ_CHILDREN
%x READ_TITLE
%x MEMORIZE

%%

<FIRSTPASS>^"(part."[^)]+")"		{ 
			strcpy(cur_command.name,yytext); hash_insert(cur_command); 
			if (strcmp(lastpart,"")) setchildren(lastpart,curchapter); curchapter=0; 
			if (strcmp(lastchapter,"")) setchildren(lastchapter,cursection); cursection=0; 
			if (strcmp(lastsection,"")) setchildren(lastsection,cursubsection); cursubsection=0; 
			if (strcmp(lastsubsection,"")) setchildren(lastsubsection,cursubsubsection); cursubsubsection=0; 
			strcpy(lastchapter,"");
			strcpy(lastsection,"");
			strcpy(lastsubsection,"");
			strcpy(lastpart,yytext); }

<FIRSTPASS>^"(chapter."[^)]+")"		{ 
			strcpy(cur_command.name,yytext); hash_insert(cur_command); 
			if (strcmp(lastchapter,"")) setchildren(lastchapter,cursection); cursection=0; 
			if (strcmp(lastsection,"")) setchildren(lastsection,cursubsection); cursubsection=0; 
			if (strcmp(lastsubsection,"")) setchildren(lastsubsection,cursubsubsection); cursubsubsection=0; 
			curchapter++;
			strcpy(lastsection,"");
			strcpy(lastsubsection,"");
			strcpy(lastchapter,yytext); }

<FIRSTPASS>^"(section."[^)]+")"		{ 
			strcpy(cur_command.name,yytext); hash_insert(cur_command); 
			if (strcmp(lastsection,"")) setchildren(lastsection,cursubsection); cursubsection=0; 
			if (strcmp(lastsubsection,"")) setchildren(lastsubsection,cursubsubsection); cursubsubsection=0; 
			cursection++;  
			strcpy(lastsubsection,"");
			strcpy(lastsection,yytext); }

<FIRSTPASS>^"(subsection."[^)]+")"		{ 
			strcpy(cur_command.name,yytext); hash_insert(cur_command); 
			if (strcmp(lastsubsection,"")) setchildren(lastsubsection,cursubsubsection); cursubsubsection=0; 
			cursubsection++;  
			strcpy(lastsubsection,yytext); }

<FIRSTPASS>^"(subsubsection."[^)]+")"		{ 
			strcpy(cur_command.name,yytext); hash_insert(cur_command); 
			cursubsubsection++; }

<FIRSTPASS>^"("[^)]*")"		{ strcpy(cur_command.name,yytext); hash_insert(cur_command); }

<FIRSTPASS>^"%!PS-Adobe-2.0"	{	
			if (strcmp(lastpart,"")) setchildren(lastpart,curchapter); curchapter=0; 
			if (strcmp(lastchapter,"")) setchildren(lastchapter,cursection); cursection=0; 
			if (strcmp(lastsection,"")) setchildren(lastsection,cursubsection); cursubsection=0; 
			if (strcmp(lastsubsection,"")) setchildren(lastsubsection,cursubsubsection); cursubsubsection=0; 
			BEGIN SECONDPASS; ECHO; }

<FIRSTPASS>.|\n		;

<SECONDPASS>.|\n	ECHO;

<SECONDPASS>"HPSdict begin"	{ ECHO; BEGIN HASH_INPUTX; }

<HASH_INPUTX>"/TargetAnchors"	ECHO;

<HASH_INPUTX>^[0-9].*		ECHO;

<HASH_INPUTX>^"(part."[^)]+")"		{ strcpy(cur_command.name,yytext); BEGIN READ_PAGE; ECHO; }

<HASH_INPUTX>^"(chapter."[^)]+")"		{ strcpy(cur_command.name,yytext); BEGIN READ_PAGE; ECHO; }

<HASH_INPUTX>^"(section."[^)]+")"		{ strcpy(cur_command.name,yytext); BEGIN READ_PAGE; ECHO; }

<HASH_INPUTX>^"(subsection."[^)]+")"		{ strcpy(cur_command.name,yytext); BEGIN READ_PAGE; ECHO; }

<HASH_INPUTX>^"(subsubsection."[^)]+")"		{ strcpy(cur_command.name,yytext); BEGIN READ_PAGE; ECHO; }

<READ_PAGE>" ["		ECHO; 

<READ_PAGE>[0-9]+		{ cur_command.page = atoi(yytext); BEGIN READ_DEST; ECHO; }

<READ_DEST>" ["[0-9]+" "[0-9]+" "[0-9]+" "[0-9]+"] "	ECHO; 

<READ_DEST>[0-9]+	{ cur_command.dest = atoi(yytext); setvalues(cur_command); ECHO; }

<READ_DEST>"] def"	{ BEGIN HASH_INPUTX; ECHO; }

<HASH_INPUTX>.|\n	ECHO; 

<HASH_INPUTX>"end targetdump-hook"	{ BEGIN IGNOREX; ECHO; }

<IGNOREX>.|\n	ECHO; 

<IGNOREX>"%%Trailer"	{ BEGIN MEMORIZE; ECHO; printf("\n"); }

<MEMORIZE>.|\n	{ strcat(bigbuffer,yytext); }

<MEMORIZE>"%%EOF"		{ strcat(bigbuffer,yytext); BEGIN 0; }

^"(part."[^)]+")"		{ strcpy(cur_command.name,yytext); look_in_hash(cur_command.name); BEGIN READ_CHILDREN; }

^"(chapter."[^)]+")"		{ strcpy(cur_command.name,yytext); look_in_hash(cur_command.name); BEGIN READ_CHILDREN; }

^"(section."[^)]+")"		{ strcpy(cur_command.name,yytext); look_in_hash(cur_command.name); BEGIN READ_CHILDREN; }

^"(subsection."[^)]+")"		{ strcpy(cur_command.name,yytext); look_in_hash(cur_command.name); BEGIN READ_CHILDREN; }

^"(subsubsection."[^)]+")"		{ strcpy(cur_command.name,yytext); look_in_hash(cur_command.name); BEGIN READ_CHILDREN; }

<READ_CHILDREN>" "+		{ 
			if (requested_children == 0) printf("[/Page %i /View [ /FitH %i ] /Title (", requested_page, requested_dest);
			else printf("[/Count %i /Page %i /View [ /FitH %i ] /Title (", requested_children, requested_page, requested_dest);
				BEGIN READ_TITLE; }

<READ_TITLE>"<<\\kern .125em{}"	{ printf("\\253"); }

<READ_TITLE>"\\kern .125em>>{}"	{ printf("\\273"); }

<READ_TITLE>"\\protect \\protect \\T1-cmd à"	{ printf("\\340"); }

<READ_TITLE>"\\protect \\protect \\T1-cmd é"	{ printf("\\351"); }

<READ_TITLE>"\\protect \\protect \\T1-cmd è"	{ printf("\\350"); }

<READ_TITLE>"\\protect \\protect \\T1-cmd É"	{ printf("\\311"); }

<READ_TITLE>"\\protect \\protect \\T1-cmd ê"	{ printf("\\352"); }

<READ_TITLE>"\\protect \\protect \\T1-cmd ô"	{ printf("\\364"); }

<READ_TITLE>"\\protect \\protect \\T1-cmd ù"	{ printf("\\371"); }

<READ_TITLE>"<"		;

<READ_TITLE>">"		{ printf(") /OUT pdfmark\n"); }

<READ_TITLE>.	ECHO;

<READ_TITLE>\n	{ BEGIN 0; }

.|\n	;

%%

unsigned int hash(char *key)
{
long int number= 0L;
int k= 0;

for(k= 0;(key[k]!=0)&&(k<32);k++) number+= abs((int)key[k]);
k= ((unsigned int)(number % HASH_TABLE_SIZE));
return k;
}

void hash_insert(command_type command)
{
unsigned int hash_value= hash(command.name);
BOOLEAN already_there= FALSE;
hash_list_pointer ptr,trail= NULL,lead= hash_table[hash_value];

for(;lead;trail= lead,lead= lead->link){
	if(!strcmp(lead->command.name,command.name))
	already_there= TRUE;
	}
if(already_there==FALSE){
	ptr= (hash_list_pointer)malloc(sizeof(struct hash_list));
	if(!(ptr)){fprintf(stderr,"\nERROR: no more memory for hashing!!...\n");
	exit(0);
	}
ptr->command= command;
ptr->link= NULL;
if(trail) trail->link= ptr;
	else hash_table[hash_value]= ptr;
if(debug==TRUE) fprintf(stderr,"%s Just placed %s in hash_table[%d]...", DEBUG_PROMPT,command.name,hash_value);}
}

void look_in_hash(char name_[32])
{
unsigned int hash_value= hash(name_);
hash_list_pointer trail= NULL,lead= hash_table[hash_value];
BOOLEAN found= FALSE;

for(;((lead)&&(found==FALSE));trail= lead,lead= lead->link){
	if(!strcmp(lead->command.name,name_)) {
		found= TRUE;
		if(debug==TRUE)fprintf(stderr,"%s Just found command %s in the hash table, it has page %d", DEBUG_PROMPT,lead->command.name,lead->command.page);
		requested_children = lead->command.children;
		requested_page = lead->command.page;
		requested_dest = lead->command.dest;
		}
	}
if(found==FALSE) {
	if(debug==TRUE)fprintf(stderr,"%s Couldn't find command %s in the hash table, putting it back into the stream", DEBUG_PROMPT,name_);
	}
}

void setchildren(char name_[32],int howmuch)
{
unsigned int hash_value= hash(name_);
hash_list_pointer trail= NULL,lead= hash_table[hash_value];
BOOLEAN found= FALSE;

for(;((lead)&&(found==FALSE));trail= lead,lead= lead->link){
	if(!strcmp(lead->command.name,name_)) {
		found= TRUE;
		if(debug==TRUE)fprintf(stderr,"%s Just found command %s in the hash table, children set to %d", DEBUG_PROMPT,lead->command.name,howmuch);
		lead->command.children = howmuch;
		}
	}
if(found==FALSE) {
	if(debug==TRUE)fprintf(stderr,"%s Couldn't find command %s in the hash table, putting it back into the stream", DEBUG_PROMPT,name_);
	}
}

void setvalues(command_type command)
{
unsigned int hash_value= hash(command.name);
hash_list_pointer trail= NULL,lead= hash_table[hash_value];
BOOLEAN found= FALSE;

for(;((lead)&&(found==FALSE));trail= lead,lead= lead->link){
	if(!strcmp(lead->command.name,command.name)) {
		found= TRUE;
		if(debug==TRUE)fprintf(stderr,"%s Just found command %s in the hash table, page set to %d, dest set to %d", 
		DEBUG_PROMPT,lead->command.name,command.page,command.dest);
		lead->command.page = command.page;
		lead->command.dest = command.dest;
		}
	}
if(found==FALSE) {
	if(debug==TRUE)fprintf(stderr,"%s Couldn't find command %s in the hash table, putting it back into the stream", DEBUG_PROMPT,command.name);
	}
}

main()
{
	BEGIN FIRSTPASS;
	yylex();
	printf("%s",bigbuffer);
}