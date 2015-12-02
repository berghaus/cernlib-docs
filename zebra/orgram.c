/**********************************************************************************/
/* Automatic Organigram Generator - Orgram.c                                      */
/* Written by Pamela Hardaker - November 1993 during Technical Student placement  */
/*                                                                                */
/* requires the deletion of ALL old files and the existance of list.text in the   */
/* format divison surname firstname group section emailaddress with spaces ONLY   */
/* between each field and nowhere else, ie replace all spaces in names with hypens*/
/**********************************************************************************/
#include <stdio.h>
main()
{
#define PEOP  5000        /* max number of people NOTE PEOP[5000] is reserved     */
#define SECS   200        /* max number of sections                               */
#define GRPS    50        /* max number of groups                                 */
#define DIVS    20        /* max number of divisions                              */ 

  FILE *tp, *fopen();     /* file pointer for text files      (generally)         */
  FILE *pp, *fopen();     /* file pointer for picture files   (generally)         */
  FILE *xp, *fopen();     /* file pointer for testing gif files                   */
  char *name;             /* pointer to count  letters in names                   */
              /* collection variables */
  char div [5], snm [30], fnm [20], grp [5], sec [ 5], sta [ 5], eml [30], chr; 
  /*temporary variables used to overcome the problem of long variable names       */
  char t0 [30], t1 [30], t2 [30], t3 [30], t4 [30], t5[30], t6[30];
  char t7 [30], t8 [30], t9 [30], t10[30], t11[30], t12[30];  
  char t13[30], t14[30], t15[30], t16[30], t17[30], t18[30];  
  int ndiv, ngrp, nsec, nper;       /* number of groups etc once counted          */
  int a, b, c, d, e , f, g, h, i;   /* Common or garden counting variables        */
                                                                                  
  struct                  /* People Records                                       */
  { char fnm   [20];      /* Forename                                             */
    char snm   [30];      /* Surname                                              */
    char div    [5];      /* Division                                             */
    char grp    [5];      /* Group                                                */
    char sec    [5];      /* Section                                              */
    char sta    [5];      /* Status                                               */
    char eml   [30];      /* Email                                                */
    int fir;              /* number of characters to be added to fnm to make 30   */
    int sir;              /* number of characters to be added to snm to make 30   */
    }  
  plst    [PEOP];         /* The People list is called plst and indexed with PEOP */

  struct                  /* Division Records                                     */
  { char div    [5];      /* Division                                             */
    int  pno;             /* The Division leader's PEOP number                    */
    int  dno;             /* The Deputy Division leader's PEOP number             */
    int  sno;             /* The Divisional Secretariat leader's PEOP number      */
  }  
  dlst    [DIVS];         /* Division list is called dlst and indexed with DIVS   */

  struct                  /* Group Records                                        */
  { char div    [5];      /* Division                                             */
    char grp    [5];      /* Group                                                */
    int  pno;             /* The Group Leader's PEOP number                       */
  }  
  glst    [GRPS];         /* The Group list is called glst and indexed with GRPS  */
  /* NOTE: div and grp stored - some grp names appear in more than one div        */
  struct                  /* Section Records                                      */
  { char div    [5];      /* Division                                             */
    char grp    [5];      /* Group                                                */
    char sec    [5];      /* Section                                              */
    int pno;              /* Section list is called slst and indexed with SECS    */
  }  
  slst    [SECS];
  /* NOTE: div,grp and sec stored - some sec names appear in more than one div    */
  struct           /* Temporary structure to hold 3 people when writing the files */
  { int pno;       /* containing photographs where 3 names are written on the     */
  }                /* first line then 3 photographs on the second                 */
  stmp   [20];          


/**********************************************************************************/
/* Open the file list.text and read each line taking each piece of information as */
/* a separate item in the order :                                                 */
/*  divison surname firstname group section emailaddress                          */
/**********************************************************************************/

  tp = fopen("list.text", "r");    /* Open file list.text and check it is valid   */
  if (!tp)                         
  printf ("The file list.text cannot be found - no files will be produced\n");

  ndiv = 0;      ngrp   = 0;
  nsec = 0;      nper   = 0;
  a  = 0;        b   = 0;
  c  = 0;        d   = 0;          /* variable initialisation */
  e  = 0;        f   = 0;
  g  = 0;        h   = 0;
  i  = 0;        chr  = ' ';      
 
  strcpy (plst[PEOP].fnm, "none found");   /* Initialisation of plst[PEOP] used   */
  strcpy (plst[PEOP].snm, " ");            /* when no leadername can be found     */
                                                                                  
  fscanf  (tp,"%s", div);                  /* Read in first item from list.text   */

  while ((chr =(getc(tp))) !=EOF )         /* Check not at end of list.text       */
       /* read in next 5 items from list.text                                     */
  { fscanf  (tp,"%s %s %s %s %s", snm, fnm, grp, sec, sta); 

    name = snm;                /* Count characters in snm and store 30 less total */
    a=0;
    while (*name != '\0')
    { a++;
      name++;
    }
    plst[nper].sir = (30-a);

    name = fnm;                /* Count characters in fnm and store 30 less total */
    a=0;
    while (*name != '\0')
    { a++;
      name++;
    }
    plst[nper].fir = (30-a);
    /* Copy data from collecting variables to indexed variables                   */
    strcpy (plst[nper].fnm, fnm); 
    strcpy (plst[nper].snm, snm);   /* This is done for all variables             */
    strcpy (plst[nper].div, div);   /* except the email identifier                */
    strcpy (plst[nper].grp, grp);
    strcpy (plst[nper].sec, sec);
    strcpy (plst[nper].sta, sta);

    a=0;                                              /* Email identifier copying */
    while ((chr =(getc(tp))) == ' ');                 /* move past white space    */
    while (chr != ' ' && chr  != '.' && chr != '\n')  /* stop if space, . , return*/
    { if (chr == '@')                                 /* replace @ with -         */
      { (chr = '-');
      }                        
      plst[nper].eml[a] = chr;      /* If all ok, copy character to eml variable  */
      chr = (getc(tp));             /* get next character                         */
      a++;
      if (a>29)                     /* Break if there are more than 30 characters */
      break;
      }

    if (chr != '\n')              /* Move to just beyond the next carriage return */
    while ((chr =(getc(tp))) != '\n' );
    nper++;                       /* Add another person to the person nubmer      */

    fscanf  (tp,"%s", div);       
    }/* end while */


/**********************************************************************************/
/* Now all the information is collected in the indexed variable plst[x] it can be */
/* parsed through to find the divisions, groups and sections and store them off   */
/* in separate lists.  This is done by nested looping, checking through the       */
/* divisions until a new one is found then checking through all the groups in that*/
/* division until a new one is found and so on with sections.                     */
/**********************************************************************************/

  /* Checking for Divisions */
  for (a=0; a<nper; a++)          /* go through every person                      */

  { for (b=0; b <20; b++)         /* use counter to step through the division list*/
                                                                                   
    { if (strcmp (plst[a].div, dlst[b].div) == 0)
      break;      /* if plst[a] = dlst[b] then it exists so stop                  */
      /* if its not in dlst then its new so write it                              */
      else if (b == (DIVS-1))  
      { strcpy (dlst[ndiv].div, plst[a].div);
      /* Now find its leader by stepping through plst again looking for DL        */
        for (i = 0; i < nper; i++)
        { if (strcmp (plst[i].div, dlst[ndiv].div) == 0) 
          { if (strcmp (plst[i].sta, "DL") == 0)
            { dlst[ndiv].pno = i;
              break;           
            }   /* if you can't find a leader use the none found                  */
            dlst[ndiv].pno = PEOP;
          }
        }           
        /* now find the deputy leader                                             */
        for (i = 0; i < nper; i ++)
        { if (strcmp (plst[i].div, dlst[ndiv].div) == 0) 
          { if (strcmp (plst[i].sta, "DDL") == 0)
            { dlst[ndiv].dno = i;
              break;           
            } /* if you can't find a leader use the none found                    */
              dlst[ndiv].dno = PEOP;
          } 
        }           
        /* and the divisional secretariat leader                                  */
        for (i = 0; i < nper; i++)
        { if (strcmp (plst[i].div, dlst[ndiv].div) == 0)
          { if (strcmp (plst[i].grp, "DI") == 0)
            { if (strcmp (plst[i].sec, "SE") == 0)                                 
              { if (strcmp (plst[i].sta, "SL") == 0)
                { dlst[ndiv].sno = i;
                  break;           
                } /* if you can't find a leader use the none found                */
                dlst[ndiv].sno = PEOP;
              } 
            } 
          }
        }          

        /* Checking for Groups                                                    */
        for (c=0; c < nper; c++)  /* go through every person                      */

        { for (d=0; d <50; d++)   /* use a counter to step through the group list */

          { if (strcmp (plst[c].div, dlst[ndiv].div) != 0)
            break;  /* if the person is not in the division just found stop       */
                                                                                   
            if ((strcmp (plst[c].grp, glst[d].grp) == 0)
            && (strcmp (plst[c].div, glst[d].div) == 0))
            break; /* if the group already exists in the division just found stop */
            /* if its not in glst then its new so write it                        */
            else if (d == (GRPS-1))
            { strcpy (glst[ngrp].grp, plst[c].grp);
              strcpy (glst[ngrp].div, plst[c].div);
              /* now find the leader by stepping through plst again looking for GL*/
              for (h=0; h < nper; h++)
              { if ((strcmp (plst[h].div, glst[ngrp].div) == 0) 
                && (strcmp (plst[h].grp, glst[ngrp].grp) == 0))
                { if (strcmp (plst[h].sta, "GL") ==0)
                  { glst[ngrp].pno = h;
                    break;           
                  } /* if you can't find a leader use the none found              */
                    glst[ngrp].pno = PEOP;
                } 
              } 
            
              /* Checking for Sections                                            */
              for (e=0; e < nper; e++)/* go through every person                  */
              { for (f=0; f <200; f++)/* use counter to step through group list   */
                { if (strcmp (plst[e].grp, glst[ngrp].grp) != 0)
                  break;/* if the person is not in the group just found stop      */

                  if (strcmp (plst[e].sec, slst[f].sec) == 0)
                  { if (strcmp (plst[e].grp, slst[f].grp) == 0)
                    { if (strcmp (plst[e].div, slst[f].div) == 0)
                      break;/* if sec already exists in the grp just found stop   */
                    }
                  }
                  /* if not in slst and it isn't there then its new so write it   */
                  else if (f == (SECS-1))
                  { strcpy (slst[nsec].sec, plst[e].sec);
                    strcpy (slst[nsec].grp, plst[e].grp);
                    strcpy (slst[nsec].div, plst[e].div);
                    /* now find the leader by looking for SL or DGL              */
                    for (g=0; g < nper; g++)
                    { if (strcmp (plst[g].sec, slst[nsec].sec) == 0)
                      { if (strcmp (plst[g].div, slst[nsec].div) == 0)
                        { if (strcmp (plst[g].grp, slst[nsec].grp) == 0)
                          { if ((strcmp (plst[g].sta, "SL") == 0) 
                            || (strcmp (plst[g].sta, "DGL") == 0))
                            { slst[nsec].pno = g;
                              break;           
                            } /* if you can't find a leader use the none found    */
                            slst[nsec].pno = PEOP;
                          }
                        }
                      }
                    } 
                    nsec++;
                    break; /*new section found, written, nsec incremented so stop */
                  }/* f reached SECS and the new section was written to slst      */
                }/* increment f and look for next section                         */
              }/* increment e and get next person                                 */
              ngrp++;                                                               
              break;
            }/* d reached GRPS and the new group was written to glst              */
          }/* increment d and look for next group                                 */
        }/* increment c and get next person                                       */
        ndiv++;
        break;
      }/* b reached DIVS and the new section written to dlst                      */
    }/* increment b and look for next division                                    */
  } /* increment a and get next person                                            */

/**********************************************************************************/
/* Finally, from the lists of people, divisions, groups and sections the html     */
/* files can be produced.  First division files are created, but, so that a 2nd   */
/* search doesn't have to be made later, the photographs of divisional leaders    */
/* are included in the already created section files and picture files.  This     */
/* saves a search from having to be done at the time of compilation of the        */
/* section files.                                                                 */
/*                                                                                */
/* The only file which is always created is main.html.  All others are dynamic.   */
/**********************************************************************************/

  /* create all org and pic files needed so that leaders can be written when found*/
  for (a=0; a < nsec; a++)

  { strcpy (t3, slst[a].div);
    strcpy (t5, slst[a].grp);
    strcpy (t6, slst[a].sec);
    sprintf  (t0, "pic_%s_%s_%s.html", t3, t5, t6);
    tp = fopen(t0, "w+");
    fprintf  (tp, "<html>\n<title>%s %s %s Section Pictures</title>\n",t3, t5,  t6);
    fprintf  (tp, "<h1>%s %s %s Section Pictures</h1>\n<body>\n<pre>\n<menu>\n", 
                  t3, t5,  t6);
    fclose (tp);
    sprintf  (t0, "org_%s_%s_%s.html", t3, t5, t6);
    tp = fopen(t0, "w+");
    fprintf  (tp, "<html>\n<title>%s %s %s Section Organigram</title>\n",t3, t5 ,t6);
    fprintf  (tp, "<h1><A NAME = %s HREF = \"information/INF_%s_%s_%s.HTML\">%s %s %s Section Organigram</A></h1>\n<body>\n<pre><menu>\n", t3, t3, t5, t6, t3, t5, t6);
    fclose (tp);
  }

  /* create the main file which always exists and from which all other files come */
  pp = fopen("main.html", "w+");
  fprintf  (pp, "<html>\n<title>CERN Organigram</title>\n");
  fprintf  (pp, "<h1>CERN Organigram</h1>\n<body>\n<pre>\n<menu>\n");
  fprintf  (pp, "<h2>Divisions within CERN\n\n\n");

  /* write out every division and its leader as an anchor point to its organigram */
  for (a=0; a < ndiv; a++)
    { strcpy   (t1, dlst[a].div);/* the t variables are used to reduce line length*/
      strcpy   (t2, plst[dlst[a].pno].fnm);/* note index is indexed variable !!   */
      strcpy   (t3, plst[dlst[a].pno].snm);
      fprintf  (pp, "<li><h2><A NAME=%s HREF=ORG_%s.HTML>%s:</A>         click  <A NAME = %s_%s HREF = \"groups/%s_coordination_info.HTML\">here</A>   for more information\n\n\n", t1, t1, t1, t1, t2, t1);
      fprintf  (pp, "          Leader:   %s %s</h2>\n\n", t2, t3); 
    }
  fclose  (pp);  /* close main.html                                               */

  /* for every division write its organigram                                      */
  for (a=0; a < ndiv; a++)
  { sprintf  (t0, "org_%s.html", dlst[a].div);/* create file name                 */
    pp = fopen(t0, "w+");                     /* open file to write and update    */
    
    fprintf  (pp, "<html>\n<title>%s Division Organigram</title>\n", dlst[a].div);
    fprintf  (pp, "<h1>%s Division Organigram</h1>\n<body>\n<pre>\n<menu>\n", t1);
   
    if (dlst[a].pno != PEOP)  /* if leader exists put details in temp variables   */
    { strcpy (t1, plst[dlst[a].pno].fnm);
      strcpy (t2, plst[dlst[a].pno].snm);
      strcpy (t3, plst[dlst[a].pno].div);
      strcpy (t4, plst[dlst[a].pno].eml);
      strcpy (t5, plst[dlst[a].pno].grp);
      strcpy (t6, plst[dlst[a].pno].sec);
      /* write Division Leader to divisional org file                             */
      fprintf  (pp, "<h2>Division Leader:                                    <A NAME = %s HREF = \"http://crnvmc.cern.ch:80/WHO/S=%s;G=%s;OU=%s;\">%s %s</A></h2>\n", t4, t2, t1, t3, t1, t2, t1, t2); 
      fprintf  (pp, "<h4>              <A NAME = %s HREF = pic_%s_%s_%s.html#%s>picture</A></h4>\n\n", t4, t3, t5, t6, t4);
      /* write Division Leader to section org file                                */
      sprintf  (t0, "org_%s_%s_%s.html", t3, t5, t6);
      tp = fopen(t0, "a");
      fprintf  (tp, "<h2>Division Leader:                                    <A NAME = %s HREF = \"http://crnvmc.cern.ch:80/WHO/S=%s;G=%s;OU=%s;\">%s %s</A></h2>\n", t4, t2, t1, t3, t1, t2, t1, t2); 
      fprintf  (tp, "<h4>              <A NAME = %s HREF = pic_%s_%s_%s.html#%s>picture</A></h4>\n\n", t4, t3, t5, t6, t4);
      fclose (tp);
      /* write Division Leader and photograph to pic file                         */
      sprintf  (t0, "pic_%s_%s_%s.html", t3, t5, t6);
      tp = fopen(t0, "a");
      fprintf  (tp, "<h2>                                                       Division Leader:     <A NAME = %s HREF = \"http://crnvmc.cern.ch:80/WHO/S=%s;G=%s;OU=%s;\">%s %s</A>\n\n</h2>", t4, t2, t1, t3, t1, t2); 

      sprintf (t0, "picture/%s.gif", t4); 
      xp = fopen (t0, "r");
      if (!xp)  /* if no gif file exists point to the standard file               */
      fprintf  (tp, "<h2>                                                                   <IMG SRC = picture/standard.gif>\n\n\n</h2>");
      else
      fprintf  (tp, "<h2>                                                                   <IMG SRC = picture/%s.gif>\n\n\n</h2>",t4);
      fclose (tp);                
      fclose (xp);
    }

    if (dlst[a].dno != PEOP)  /* if leader exists put details in temp variables   */
    { strcpy (t1, plst[dlst[a].dno].fnm);
      strcpy (t2, plst[dlst[a].dno].snm);
      strcpy (t3, plst[dlst[a].dno].div);
      strcpy (t4, plst[dlst[a].dno].eml);
      strcpy (t5, plst[dlst[a].dno].grp);
      strcpy (t6, plst[dlst[a].dno].sec);
      /* write Deputy Division Leader to divisional org file                      */
      fprintf  (pp, "<h2>Deputy to the Division Leader:        <A NAME = %s HREF = \"http://crnvmc.cern.ch:80/WHO/S=%s;G=%s;OU=%s;\">%s %s</A></h2>\n", t4, t2, t1, t3, t1, t2, t1, t2); 
      fprintf  (pp, "<h4>              <A NAME = %s HREF = pic_%s_%s_%s.html#%s>picture</A></h4>\n\n", t4, t3, t5, t6, t4);
      /* write Deputy Division Leader to sectional org file                       */
      sprintf  (t0, "org_%s_%s_%s.html", t3, t5, t6);
      tp = fopen(t0, "a");
      fprintf  (tp, "<h2>Deputy to the Division Leader:        <A NAME = %s HREF = \"http://crnvmc.cern.ch:80/WHO/S=%s;G=%s;OU=%s;\">%s %s</A></h2>\n", t4, t2, t1, t3, t1, t2, t1, t2); 
      fprintf  (tp, "<h4>              <A NAME = %s HREF = pic_%s_%s_%s.html#%s>picture</A></h4>\n\n", t4, t3, t5, t6, t4);
      fclose   (tp);
      /* write Division Leader and photograph to pic file                         */
      sprintf  (t0, "pic_%s_%s_%s.html", t3, t5, t6);
      tp = fopen(t0, "a");
      fprintf  (tp, "<h2>                                                       Deputy to the Division Leader:     <A NAME = %s HREF = \"http://crnvmc.cern.ch:80/WHO/S=%s;G=%s;OU=%s;\">%s %s</A>\n\n</h2>", t4, t2, t1, t3, t1, t2); 
 
      sprintf (t0, "picture/%s.gif", t4); 
      xp = fopen (t0, "r");
      if (!xp)
      fprintf  (tp, "<h2>                                                                   <IMG SRC = picture/standard.gif>\n\n\n</h2>");
      else
      fprintf  (tp, "<h2>                                                                   <IMG SRC = picture/%s.gif>\n\n\n</h2>",t4);
      fclose (tp);
      fclose (xp);
    }

    if (dlst[a].sno != PEOP)  /* if leader exists put details in temp variables   */
    { strcpy (t1, plst[dlst[a].sno].fnm);
      strcpy (t2, plst[dlst[a].sno].snm);
      strcpy (t3, plst[dlst[a].sno].div);
      strcpy (t4, plst[dlst[a].sno].eml);
      strcpy (t5, plst[dlst[a].sno].grp);
      strcpy (t6, plst[dlst[a].sno].sec);
      /* write Divisional Secretariat Leader to divisional org file               */
      fprintf  (pp, "<h2>Divisional Secretariat:                        <A NAME = %s HREF = \"http://crnvmc.cern.ch:80/WHO/S=%s;G=%s;OU=%s;\">%s %s</A></h2>\n", t4, t2, t1, t3, t1, t2, t1, t2);
      fprintf  (pp, "<h4>              <A NAME = %s HREF = pic_%s_%s_%s.html#%s>picture</A></h4>\n\n", t4, t3, t5, t6, t4);
    }

    fprintf  (pp, "<h2>Groups within %s Division</h2>\n\n", dlst[a].div);
    for (b=0; b < ngrp; b++)
    { if (strcmp (dlst[a].div, glst[b].div) == 0)
      { strcpy (t1, glst[b].div);
        strcpy (t2, glst[b].grp);
        strcpy (t3, plst[glst[b].pno].fnm);
        strcpy (t4, plst[glst[b].pno].snm);
        fprintf  (pp, "<li><h4><A NAME = %s_%s HREF = \"ORG_%s_%s.HTML\">%s %s:</A>          click <A NAME = %s_%s HREF = \"groups/%s_%s_info.HTML\">here</A> for more information</h4>\n", t1, t2, t1, t2, t1, t2, t1, t2, t1, t2 ); 
        fprintf  (pp, "<h4>           Leader:   %s %s</h4>\n\n", t3, t4);           
      }
    }   
    fprintf (pp, "<h4>Please send comments and suggestions on this layout to: ");
    fprintf  (pp, "<A NAME = Hardaker HREF = \"http://crnvmc.cern.ch:80/WHO/S=HARDAKER;G=PAMELA;OU=CN;\">Pamela Hardaker</A>\n");
    fprintf  (pp, "<A NAME = orgram.t HREF = Orgram.Text>Information on this program</A></h4>\n");
    fclose  (tp);
    fclose  (pp);
  }
  /* for every group write its organigram                                         */
  for (a=0; a < ngrp; a++) 
  { sprintf  (t0, "org_%s_%s.html", glst[a].div, glst[a].grp);
    pp = fopen(t0, "w+");
    fprintf  (pp, "<html>\n<title>%s %s Group Organigram</title>\n", glst[a].div, glst[a].grp);
    fprintf  (pp, "<h1>%s %s Group Organigram</h1>\n<body>\n<pre><menu>\n", glst[a].div, glst[a].grp);
 
    if (glst[a].pno != PEOP)  /* if leader exists put details in temp variables   */
    { strcpy (t1, plst[glst[a].pno].fnm);
      strcpy (t2, plst[glst[a].pno].snm);
      strcpy (t3, plst[glst[a].pno].div);
      strcpy (t4, plst[glst[a].pno].eml);
      strcpy (t5, plst[glst[a].pno].grp);
      strcpy (t6, plst[glst[a].pno].sec);
      /* write Group Leader to divisional org file                                */
      fprintf  (pp, "<h2>Group Leader:       <A NAME = %s HREF = \"http://crnvmc.cern.ch:80/WHO/S=%s;G=%s;OU=%s;\">%s %s</A></h2>\n", t4, t2, t1, t3, t1, t2, t1, t2);
      fprintf  (pp, "<h4>              <A NAME = %s HREF = pic_%s_%s_%s.html#%s>picture</A></h4>\n\n", t4, t3, t5, t6, t4);
      /* write Group Leader to sectional  org file                                */
      sprintf  (t0, "org_%s_%s_%s.html", t3, t5, t6);
      tp = fopen(t0, "a");
      fprintf  (tp, "<h2>Group Leader:       <A NAME = %s HREF = \"http://crnvmc.cern.ch:80/WHO/S=%s;G=%s;OU=%s;\">%s %s</A></h2>\n", t4, t2, t1, t3, t1, t2, t1, t2);
      fprintf  (tp, "<h4>              <A NAME = %s HREF = pic_%s_%s_%s.html#%s>picture</A></h4>\n\n", t4, t3, t5, t6, t4);
      fclose (tp);
      /* write Group Leader and photograph to pic file                            */
      sprintf  (t0, "pic_%s_%s_%s.html", t3, t5, t6);
      tp = fopen(t0, "a");
      fprintf  (tp, "<h2>                                                       Group Leader:     <A NAME = %s HREF = \"http://crnvmc.cern.ch:80/WHO/S=%s;G=%s;OU=%s;\">%s %s</A>\n\n</h2>", t4, t2, t1, t3, t1, t2); 

      sprintf (t0, "picture/%s.gif", t4); 
      xp = fopen (t0, "r");
      if (!xp)
      fprintf  (tp, "<h2>                                                                   <IMG SRC = picture/standard.gif>\n\n\n</h2>");
      else
      fprintf  (tp, "<h2>                                                                   <IMG SRC = picture/%s.gif>\n\n\n</h2>",t4);
      fclose (tp);
      fclose (xp);
   }

    fprintf  (pp, "<h2>Sections within %s %s Group\n\n</h2>", glst[a].div, glst[a].grp);
    for (b = 0; b < nsec; b++)                                                                                           
    { if ((strcmp (glst[a].div, slst[b].div) == 0)&&(strcmp (glst[a].grp, slst[b].grp) == 0))
      { strcpy (t1, slst[b].div);
        strcpy (t2, slst[b].grp);
        strcpy (t3, slst[b].sec);
        strcpy (t4, plst[slst[b].pno].fnm);
        strcpy (t5, plst[slst[b].pno].snm);
        fprintf  (pp, "<li><h4><A NAME = %s_%s_%s HREF = \"ORG_%s_%s_%s.HTML\">%s %s %s:</A></h4>\n", t1, t2, t3, t1, t2, t3, t1, t2, t3);
        fprintf  (pp, "<h4>           Leader:   %s %s</h4>\n\n", t4, t5); 
      }
    }
    fprintf  (pp, "<h4>Return to  <A NAME = %s HREF = org_%s.html >%s Division Organigram</A></h2>",t1, t1, t1); 
    fprintf  (pp, "</pre>");
    fclose   (pp);
  }    
  /* for every section write its organigram                                       */
  for (a = 0; a < nsec; a++)
  { sprintf  (t0, "org_%s_%s_%s.html", slst[a].div, slst[a].grp, slst[a].sec);
    pp = fopen(t0, "a");
    sprintf  (t0, "pic_%s_%s_%s.html", slst[a].div, slst[a].grp, slst[a].sec);
    tp = fopen(t0, "a");
 
    if (slst[a].pno != PEOP ) /* if leader exists put details in temp variables   */
    { strcpy (t1, plst[slst[a].pno].fnm);
      strcpy (t2, plst[slst[a].pno].snm);
      strcpy (t3, plst[slst[a].pno].div);
      strcpy (t4, plst[slst[a].pno].eml);
      strcpy (t5, plst[slst[a].pno].grp);
      strcpy (t6, plst[slst[a].pno].sec);
      /* write Section Leader to sectional org file                              */
      fprintf  (pp, "<h2>Section Leader:        <A NAME = %s HREF = \"http://crnvmc.cern.ch:80/WHO/S=%s;G=%s;OU=%s;\">%s %s</A></h2>\n", t4, t2, t1, t3, t1, t2);
      fprintf  (pp, "<h4>              <A NAME = %s HREF = pic_%s_%s_%s.html#%s>picture</A></h4>\n\n",t4, t3, t5, t6, t4);
      /* write Group Leader and photograph to pic file                           */
      fprintf  (tp, "<h2>                                                       Section Leader:     <A NAME = %s HREF = \"http://crnvmc.cern.ch:80/WHO/S=%s;G=%s;OU=%s;\">%s %s</A>\n\n</h2>", t4, t2, t1, t3, t1, t2); 
      sprintf (t0, "picture/%s.gif", t4); 
      xp = fopen (t0, "r");
      if (!xp)
      fprintf  (tp, "<h2>                                                                   <IMG SRC = picture/standard.gif>\n\n\n</h2>");
      else
      fprintf  (tp, "<h2>                                                                   <IMG SRC = picture/%s.gif>\n\n\n</h2>",t4);
      fclose (xp); 
    }
 
    c = 0;
    d = 0;

    /* find all people for this section and store in temporary struct stmp        */
    for (b=0; b < nper; b++)
    { if ((strcmp (slst[a].div, plst[b].div) == 0)&&(strcmp (slst[a].grp, plst[b].grp) == 0)&&(strcmp (slst[a].sec, plst[b].sec) == 0))
      { if ( strcmp (plst[b].sta, "-") == 0)
        { stmp[c].pno = b; 
          c++;
        }
      }
    } 
    /* if you're not at the end of stmp, copy the next set of variables          */
    while (d < c)
    { strcpy (t1, plst[stmp[d].pno].fnm);
      strcpy (t2, plst[stmp[d].pno].snm);
      strcpy (t3, plst[stmp[d].pno].div);
      strcpy (t4, plst[stmp[d].pno].eml);
      strcpy (t5, plst[stmp[d].pno].grp);
      strcpy (t6, plst[stmp[d].pno].sec);
      e = plst[stmp[d].pno].sir;
      f = plst[stmp[d].pno].fir;
      d++;

      /* if you're not at the end of stmp, copy the next set of variables        */
      if (d < c)
      { strcpy (t7, plst[stmp[d].pno].fnm);
        strcpy (t8, plst[stmp[d].pno].snm);
        strcpy (t9, plst[stmp[d].pno].div);
        strcpy (t10, plst[stmp[d].pno].eml);
        strcpy (t11, plst[stmp[d].pno].grp);
        strcpy (t12, plst[stmp[d].pno].sec);
        g = plst[stmp[d].pno].sir;
        h = plst[stmp[d].pno].fir;
        d++;
      }
      else 
      strcpy (t7, "*");/* if that was the end of stmp flag it here               */
 
      if (d < c)
      { 
        strcpy (t13, plst[stmp[d].pno].fnm);
        strcpy (t14, plst[stmp[d].pno].snm);
        strcpy (t15, plst[stmp[d].pno].div);
        strcpy (t16, plst[stmp[d].pno].eml);
        strcpy (t17, plst[stmp[d].pno].grp);
        strcpy (t18, plst[stmp[d].pno].sec);
        d++;    
      }
      else 
      strcpy (t13, "*");/* if that was the end of stmp flag it here               */

      /* print the name and picture reference of the next person to the org file  */
      fprintf  (pp, "<li><h4><A NAME = %s HREF = \"http://crnvmc.cern.ch:80/WHO/S=%s;G=%s;OU=%s;\">%s %s</A></h4>\n\n", t4, t2, t1, t3, t1, t2); 
      fprintf  (pp, "<h4>              <A NAME = %s HREF = pic_%s_%s_%s.html#%s>picture</A></h4>\n\n", t4, t3, t5, t6, t4);
      /* if there is another person print their name and picture reference        */
      if (strcmp (t7, "*") != 0)
      { fprintf  (pp, "<li><h4><A NAME = %s HREF = \"http://crnvmc.cern.ch:80/WHO/S=%s;G=%s;OU=%s;\">%s %s</A></h4>\n\n", t10, t8, t7, t9, t7, t8); 
        fprintf  (pp, "<h4>              <A NAME = %s HREF = pic_%s_%s_%s.html#%s>picture</A></h4>\n\n", t4, t3, t5, t6, t4);
      }
      /* if there is another person print their name and picture reference        */
      if (strcmp (t13, "*") != 0)
      { fprintf  (pp, "<li><h4><A NAME = %s HREF = \"http://crnvmc.cern.ch:80/WHO/S=%s;G=%s;OU=%s;\">%s %s</A></h4>\n\n", t16, t14, t13, t15, t13, t14); 
        fprintf  (pp, "<h4>              <A NAME = %s HREF = pic_%s_%s_%s.html#%s>picture</A></h4>\n\n", t4, t3, t5, t6, t4);
      }

      /* print the first name of the next person to the pic file                  */ 
      fprintf  (tp, "%s",t1); 
      for (i=0; i<f; i++)
      fprintf  (tp, " "); /* count on the number of spaces needed to make 30      */ 
      /* if there is another person print their first name on the same line       */
      if (strcmp (t7, "*") != 0)
      { fprintf  (tp, "%s",t7);
      }
      for (i=0; i<h; i++)
      fprintf  (tp, " "); /* count on the number of spaces needed to make 30      */ 
      /* if there is another one print their first name too                       */
      if (strcmp (t13, "*") != 0)
      { fprintf  (tp, "%s",t13); 
      }

      /* print a return and the second name of the next person to the pic file    */
      fprintf  (tp, "\n<A NAME = %s HREF = \"http://crnvmc.cern.ch:80/WHO/S=%s;G=%s;OU=%s;\">%s</A>",t4, t2, t3, t1, t2); 
      for (i=0; i<e; i++)
      fprintf  (tp, " "); /* count on the number of spaces needed to make 30      */ 
      /* if there is another person print their second name on the same line      */ 
      if (strcmp (t7, "*") != 0)
      { fprintf  (tp, "<A NAME = %s HREF = \"http://crnvmc.cern.ch:80/WHO/S=%s;G=%s;OU=%s;\">%s</A>",t10, t8, t9, t7, t8); 
      }
      for (i=0; i<g; i++)
      fprintf  (tp, " "); /* count on the number of spaces needed to make 30      */ 
      /* if there is another one print their second name too                      */
      if (strcmp (t13, "*") != 0)
      { fprintf  (tp, "<A NAME = %s HREF = \"http://crnvmc.cern.ch:80/WHO/S=%s;G=%s;OU=%s;\">%s</A>",t16, t14, t15, t13, t14); 
      }                

      /* print 2 carriage returns and the next person's picture                   */
      sprintf (t0, "picture/%s.gif", t4); 
      xp = fopen (t0, "r");
      if (!xp)
      fprintf  (tp, "\n\n<IMG SRC = picture/standard.gif>");
      else
      fprintf  (tp, "\n\n<IMG SRC = picture/%s.gif>",t4);
      fclose (xp);

      /* if there is another person print their picture on the same line          */
      if (strcmp (t7, "*") != 0)
      { fprintf  (tp, "                   ");
        sprintf (t0, "picture/%s.gif", t10); 
        xp = fopen (t0, "r");
        if (!xp)
        fprintf  (tp, "<IMG SRC = picture/standard.gif>");
        else
        fprintf  (tp, "<IMG SRC = picture/%s.gif>",t10);
        fclose (xp);
      }
 
      /* if there is another person print their picture on the same line          */
      if (strcmp (t13, "*") != 0)
      { fprintf  (tp, "                   ");
        sprintf (t0, "picture/%s.gif", t16); 
        xp = fopen (t0, "r");
        if (!xp)
        fprintf  (tp, "<IMG SRC = picture/standard.gif>\n\n\n");
        else
        fprintf  (tp, "<IMG SRC = picture/%s.gif>\n\n\n",t16);
        fclose (xp);
      }
    }
    /* print the return calls to other organigrams                                */
    fprintf  (tp, "<h4>\n\nReturn to  <A NAME = %s HREF = org_%s_%s_%s.html >%s Section Organigram</A></h4>",t6, t3, t5, t6, t6); 
    fprintf  (tp, "<h4>Return to  <A NAME = %s HREF = org_%s_%s.html >%s Group Organigram</A></h4>",t5, t3, t5, t5); 
    fprintf  (tp, "<h4>Return to  <A NAME = %s HREF = org_%s.html >%s Division Organigram</A></h4>",t3, t3, t3); 
    fprintf  (tp, "</pre>");
    fprintf  (pp, "<h4>Return to  <A NAME = %s HREF = org_%s_%s.html >%s Group Organigram</A></h2>",t5, t3, t5, t5); 
    fprintf  (pp, "<h4>Return to  <A NAME = %s HREF = org_%s.html >%s Division Organigram</A></h2>",t3, t3, t3); 
    fprintf  (pp, "</pre>");
    fclose   (tp);
    fclose   (pp);
  }
}
