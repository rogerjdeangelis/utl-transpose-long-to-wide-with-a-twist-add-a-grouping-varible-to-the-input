Transpose long to wide with a twist add a grouping varible to the input                                                       
                                                                                                                              
No need for the merge if you add one statement to the input.                                                                  
                                                                                                                              
Also there appears to be an error in the example output                                                                       
                                                                                                                              
   4 5/6/2009 head N inp                                                                                                      
                                                                                                                              
 in your example output                                                                                                       
                                                                                                                              
You have it appearing with the  'out'  location.                                                                              
                                                                                                                              
The approved solution did not work for me.                                                                                    
                                                                                                                              
github                                                                                                                        
http://tinyurl.com/y5xhas3q                                                                                                   
https://github.com/rogerjdeangelis/utl-transpose-long-to-wide-with-a-twist-add-a-grouping-varible-to-the-input                
                                                                                                                              
SAS Forum                                                                                                                     
http://tinyurl.com/y5hcfues                                                                                                   
https://communities.sas.com/t5/SAS-Programming/transpose-into-wide-format/m-p/569832                                          
                                                                                                                              
data have;                                                                                                                    
      input enrolid1 date1 : mmddyy10. test $ result $ location $;                                                            
      format date1 mmddyy10.;                                                                                                 
      retain blod;                                                                                                            
      length blod $8;                                                                                                         
      if test="blood" then do; blod=result; end;                                                                              
      else output;                                                                                                            
 cards4;                                                                                                                      
4 5/5/2009 blood 65 inp                                                                                                       
4 5/5/2009 colon Y inp                                                                                                        
4 5/5/2009 stomach Y inp                                                                                                      
4 5/6/2009 head N inp                                                                                                         
4 5/6/2009 blood 55 out                                                                                                       
4 5/6/2009 colon N out                                                                                                        
4 5/6/2009 stomach N out                                                                                                      
4 5/6/2009 neck Y out                                                                                                         
4 5/6/2009 ZY Y out                                                                                                           
5 5/5/2009 blood 55 inp                                                                                                       
5 5/5/2009 add Y inp                                                                                                          
5 5/5/2009 mst N inp                                                                                                          
;;;;                                                                                                                          
run;quit;                                                                                                                     
                                                                                                                              
                                                                                                                              
HAVE total obs=9                                                  | RULES (added BKOD COLUMN)                                 
                                                                  |                                                           
Obs    ENROLID1    DATE1    TEST       RESULT    LOCATION   BLOD  | Just retain blood as BLOD                                 
                                                                  | and add to transpose by                                   
 1         4       18022    colon        Y         inp       65   |                                                           
 2         4       18022    stomach      Y         inp       65   | Make blod a grouping                                      
 3         4       18023    head         N         inp       65   | variable                                                  
 4         4       18023    colon        N         out       55   |                                                           
 5         4       18023    stomach      N         out       55   |                                                           
 6         4       18023    neck         Y         out       55   |                                                           
 7         4       18023    ZY           Y         out       55   |                                                           
 8         5       18022    add          Y         inp       55   |                                                           
 9         5       18022    mst          N         inp       55   |                                                           
*            _               _                                                                                                
  ___  _   _| |_ _ __  _   _| |_                                                                                              
 / _ \| | | | __| '_ \| | | | __|                                                                                             
| (_) | |_| | |_| |_) | |_| | |_                                                                                              
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                             
                |_|                                                                                                           
;                                                                                                                             
                                                                                                                              
Up to 40 obs WORK.WANT total obs=4                                                                                            
                                  *******                                                                                     
                                  added                                                                                       
                                  this                                                                                        
                                  col                                                                                         
                                  *******                                                                                     
 ENROLID1    DATE1    LOCATION    BLOD COLON    STOMACH    HEAD    NECK    ZY    ADD    MST                                   
                                                                                                                              
     4       18022      inp        65    Y         Y                                                                          
     4       18023      inp        65                       N                                                                 
     4       18023      out        55    N         N                Y      Y                                                  
     5       18022      inp        55                                             Y      N                                    
                                                                  |                                                           
*          _       _   _                                                                                                      
 ___  ___ | |_   _| |_(_) ___  _ __                                                                                           
/ __|/ _ \| | | | | __| |/ _ \| '_ \                                                                                          
\__ \ (_) | | |_| | |_| | (_) | | | |                                                                                         
|___/\___/|_|\__,_|\__|_|\___/|_| |_|                                                                                         
                                                                                                                              
;                                                                                                                             
                                                                                                                              
proc transpose data=have out=want;                                                                                            
    by enrolid1 date1 location blod;                                                                                          
      id test ;                                                                                                               
      var result;                                                                                                             
run;quit;                                                                                                                     
                                                                                                                              
                                                                                                  
                                                                                                                  
                                                                                                                  
