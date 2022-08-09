***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4 
      F_Class  $ 20
      I_Class  $ 20
      U_Class  $ 20
;
      label S_deg_malig = 'Standard: deg_malig' ;

      label age20_29 = 'Dummy: age=20-29' ;

      label age30_39 = 'Dummy: age=30-39' ;

      label age40_49 = 'Dummy: age=40-49' ;

      label age50_59 = 'Dummy: age=50-59' ;

      label age60_69 = 'Dummy: age=60-69' ;

      label breastleft = 'Dummy: breast=left' ;

      label breast_quad_ = 'Dummy: breast_quad=?' ;

      label breast_quadcentral = 'Dummy: breast_quad=central' ;

      label breast_quadleft_low = 'Dummy: breast_quad=left_low' ;

      label breast_quadleft_up = 'Dummy: breast_quad=left_up' ;

      label breast_quadright_low = 'Dummy: breast_quad=right_low' ;

      label inv_nodes0_2 = 'Dummy: inv_nodes=0-2' ;

      label inv_nodes12_14 = 'Dummy: inv_nodes=12-14' ;

      label inv_nodes15_17 = 'Dummy: inv_nodes=15-17' ;

      label inv_nodes24_26 = 'Dummy: inv_nodes=24-26' ;

      label inv_nodes3_5 = 'Dummy: inv_nodes=3-5' ;

      label inv_nodes6_8 = 'Dummy: inv_nodes=6-8' ;

      label irradiatno = 'Dummy: irradiat=no' ;

      label menopausege40 = 'Dummy: menopause=ge40' ;

      label menopauselt40 = 'Dummy: menopause=lt40' ;

      label node_caps_ = 'Dummy: node_caps=?' ;

      label node_capsno = 'Dummy: node_caps=no' ;

      label tumor_size0_4 = 'Dummy: tumor_size=0-4' ;

      label tumor_size10_14 = 'Dummy: tumor_size=10-14' ;

      label tumor_size15_19 = 'Dummy: tumor_size=15-19' ;

      label tumor_size20_24 = 'Dummy: tumor_size=20-24' ;

      label tumor_size25_29 = 'Dummy: tumor_size=25-29' ;

      label tumor_size30_34 = 'Dummy: tumor_size=30-34' ;

      label tumor_size35_39 = 'Dummy: tumor_size=35-39' ;

      label tumor_size40_44 = 'Dummy: tumor_size=40-44' ;

      label tumor_size45_49 = 'Dummy: tumor_size=45-49' ;

      label tumor_size5_9 = 'Dummy: tumor_size=5-9' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label I_Class = 'Into: Class' ;

      label F_Class = 'From: Class' ;

      label U_Class = 'Unnormalized Into: Class' ;

      label P_Classrecurrence_events = 'Predicted: Class=recurrence-events' ;

      label R_Classrecurrence_events = 'Residual: Class=recurrence-events' ;

      label P_Classno_recurrence_events = 
'Predicted: Class=no-recurrence-events' ;

      label R_Classno_recurrence_events = 
'Residual: Class=no-recurrence-events' ;

      label  _WARN_ = "Warnings"; 

*** Generate dummy variables for age ;
drop age20_29 age30_39 age40_49 age50_59 age60_69 ;
*** encoding is sparse, initialize to zero;
age20_29 = 0;
age30_39 = 0;
age40_49 = 0;
age50_59 = 0;
age60_69 = 0;
if missing( age ) then do;
   age20_29 = .;
   age30_39 = .;
   age40_49 = .;
   age50_59 = .;
   age60_69 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm5 $ 5; drop _dm5 ;
   _dm5 = put( age , $5. );
   %DMNORMIP( _dm5 )
   _dm_find = 0; drop _dm_find;
   if _dm5 <= '40-49'  then do;
      if _dm5 <= '30-39'  then do;
         if _dm5 = '20-29'  then do;
            age20_29 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm5 = '30-39'  then do;
               age30_39 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm5 = '40-49'  then do;
            age40_49 = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm5 <= '60-69'  then do;
         if _dm5 = '50-59'  then do;
            age50_59 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm5 = '60-69'  then do;
               age60_69 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm5 = '70-79'  then do;
            age20_29 = -1;
            age30_39 = -1;
            age40_49 = -1;
            age50_59 = -1;
            age60_69 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      age20_29 = .;
      age30_39 = .;
      age40_49 = .;
      age50_59 = .;
      age60_69 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for breast ;
drop breastleft ;
if missing( breast ) then do;
   breastleft = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm5 $ 5; drop _dm5 ;
   _dm5 = put( breast , $5. );
   %DMNORMIP( _dm5 )
   if _dm5 = 'LEFT'  then do;
      breastleft = 1;
   end;
   else if _dm5 = 'RIGHT'  then do;
      breastleft = -1;
   end;
   else do;
      breastleft = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for breast_quad ;
drop breast_quad_ breast_quadcentral breast_quadleft_low breast_quadleft_up 
        breast_quadright_low ;
*** encoding is sparse, initialize to zero;
breast_quad_ = 0;
breast_quadcentral = 0;
breast_quadleft_low = 0;
breast_quadleft_up = 0;
breast_quadright_low = 0;
if missing( breast_quad ) then do;
   breast_quad_ = .;
   breast_quadcentral = .;
   breast_quadleft_low = .;
   breast_quadleft_up = .;
   breast_quadright_low = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm9 $ 9; drop _dm9 ;
   %DMNORMCP( breast_quad , _dm9 )
   if _dm9 = 'LEFT_UP'  then do;
      breast_quadleft_up = 1;
   end;
   else if _dm9 = 'LEFT_LOW'  then do;
      breast_quadleft_low = 1;
   end;
   else if _dm9 = 'RIGHT_UP'  then do;
      breast_quad_ = -1;
      breast_quadcentral = -1;
      breast_quadleft_low = -1;
      breast_quadleft_up = -1;
      breast_quadright_low = -1;
   end;
   else if _dm9 = 'CENTRAL'  then do;
      breast_quadcentral = 1;
   end;
   else if _dm9 = 'RIGHT_LOW'  then do;
      breast_quadright_low = 1;
   end;
   else if _dm9 = '?'  then do;
      breast_quad_ = 1;
   end;
   else do;
      breast_quad_ = .;
      breast_quadcentral = .;
      breast_quadleft_low = .;
      breast_quadleft_up = .;
      breast_quadright_low = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for inv_nodes ;
drop inv_nodes0_2 inv_nodes12_14 inv_nodes15_17 inv_nodes24_26 inv_nodes3_5 
        inv_nodes6_8 ;
*** encoding is sparse, initialize to zero;
inv_nodes0_2 = 0;
inv_nodes12_14 = 0;
inv_nodes15_17 = 0;
inv_nodes24_26 = 0;
inv_nodes3_5 = 0;
inv_nodes6_8 = 0;
if missing( inv_nodes ) then do;
   inv_nodes0_2 = .;
   inv_nodes12_14 = .;
   inv_nodes15_17 = .;
   inv_nodes24_26 = .;
   inv_nodes3_5 = .;
   inv_nodes6_8 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm5 $ 5; drop _dm5 ;
   %DMNORMCP( inv_nodes , _dm5 )
   if _dm5 = '0-2'  then do;
      inv_nodes0_2 = 1;
   end;
   else if _dm5 = '3-5'  then do;
      inv_nodes3_5 = 1;
   end;
   else if _dm5 = '6-8'  then do;
      inv_nodes6_8 = 1;
   end;
   else if _dm5 = '15-17'  then do;
      inv_nodes15_17 = 1;
   end;
   else if _dm5 = '9-11'  then do;
      inv_nodes0_2 = -1;
      inv_nodes12_14 = -1;
      inv_nodes15_17 = -1;
      inv_nodes24_26 = -1;
      inv_nodes3_5 = -1;
      inv_nodes6_8 = -1;
   end;
   else if _dm5 = '12-14'  then do;
      inv_nodes12_14 = 1;
   end;
   else if _dm5 = '24-26'  then do;
      inv_nodes24_26 = 1;
   end;
   else do;
      inv_nodes0_2 = .;
      inv_nodes12_14 = .;
      inv_nodes15_17 = .;
      inv_nodes24_26 = .;
      inv_nodes3_5 = .;
      inv_nodes6_8 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for irradiat ;
drop irradiatno ;
if missing( irradiat ) then do;
   irradiatno = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm3 $ 3; drop _dm3 ;
   _dm3 = put( irradiat , $3. );
   %DMNORMIP( _dm3 )
   if _dm3 = 'NO'  then do;
      irradiatno = 1;
   end;
   else if _dm3 = 'YES'  then do;
      irradiatno = -1;
   end;
   else do;
      irradiatno = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for menopause ;
drop menopausege40 menopauselt40 ;
if missing( menopause ) then do;
   menopausege40 = .;
   menopauselt40 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm7 $ 7; drop _dm7 ;
   _dm7 = put( menopause , $7. );
   %DMNORMIP( _dm7 )
   if _dm7 = 'PREMENO'  then do;
      menopausege40 = -1;
      menopauselt40 = -1;
   end;
   else if _dm7 = 'GE40'  then do;
      menopausege40 = 1;
      menopauselt40 = 0;
   end;
   else if _dm7 = 'LT40'  then do;
      menopausege40 = 0;
      menopauselt40 = 1;
   end;
   else do;
      menopausege40 = .;
      menopauselt40 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for node_caps ;
drop node_caps_ node_capsno ;
if missing( node_caps ) then do;
   node_caps_ = .;
   node_capsno = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm3 $ 3; drop _dm3 ;
   %DMNORMCP( node_caps , _dm3 )
   if _dm3 = 'NO'  then do;
      node_caps_ = 0;
      node_capsno = 1;
   end;
   else if _dm3 = 'YES'  then do;
      node_caps_ = -1;
      node_capsno = -1;
   end;
   else if _dm3 = '?'  then do;
      node_caps_ = 1;
      node_capsno = 0;
   end;
   else do;
      node_caps_ = .;
      node_capsno = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for tumor_size ;
drop tumor_size0_4 tumor_size10_14 tumor_size15_19 tumor_size20_24 
        tumor_size25_29 tumor_size30_34 tumor_size35_39 tumor_size40_44 
        tumor_size45_49 tumor_size5_9 ;
*** encoding is sparse, initialize to zero;
tumor_size0_4 = 0;
tumor_size10_14 = 0;
tumor_size15_19 = 0;
tumor_size20_24 = 0;
tumor_size25_29 = 0;
tumor_size30_34 = 0;
tumor_size35_39 = 0;
tumor_size40_44 = 0;
tumor_size45_49 = 0;
tumor_size5_9 = 0;
if missing( tumor_size ) then do;
   tumor_size0_4 = .;
   tumor_size10_14 = .;
   tumor_size15_19 = .;
   tumor_size20_24 = .;
   tumor_size25_29 = .;
   tumor_size30_34 = .;
   tumor_size35_39 = .;
   tumor_size40_44 = .;
   tumor_size45_49 = .;
   tumor_size5_9 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm5 $ 5; drop _dm5 ;
   %DMNORMCP( tumor_size , _dm5 )
   _dm_find = 0; drop _dm_find;
   if _dm5 <= '30-34'  then do;
      if _dm5 <= '15-19'  then do;
         if _dm5 <= '10-14'  then do;
            if _dm5 = '0-4'  then do;
               tumor_size0_4 = 1;
               _dm_find = 1;
            end;
            else do;
               if _dm5 = '10-14'  then do;
                  tumor_size10_14 = 1;
                  _dm_find = 1;
               end;
            end;
         end;
         else do;
            if _dm5 = '15-19'  then do;
               tumor_size15_19 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm5 <= '25-29'  then do;
            if _dm5 = '20-24'  then do;
               tumor_size20_24 = 1;
               _dm_find = 1;
            end;
            else do;
               if _dm5 = '25-29'  then do;
                  tumor_size25_29 = 1;
                  _dm_find = 1;
               end;
            end;
         end;
         else do;
            if _dm5 = '30-34'  then do;
               tumor_size30_34 = 1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   else do;
      if _dm5 <= '45-49'  then do;
         if _dm5 <= '40-44'  then do;
            if _dm5 = '35-39'  then do;
               tumor_size35_39 = 1;
               _dm_find = 1;
            end;
            else do;
               if _dm5 = '40-44'  then do;
                  tumor_size40_44 = 1;
                  _dm_find = 1;
               end;
            end;
         end;
         else do;
            if _dm5 = '45-49'  then do;
               tumor_size45_49 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm5 = '5-9'  then do;
            tumor_size5_9 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm5 = '50-54'  then do;
               tumor_size0_4 = -1;
               tumor_size10_14 = -1;
               tumor_size15_19 = -1;
               tumor_size20_24 = -1;
               tumor_size25_29 = -1;
               tumor_size30_34 = -1;
               tumor_size35_39 = -1;
               tumor_size40_44 = -1;
               tumor_size45_49 = -1;
               tumor_size5_9 = -1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   if not _dm_find then do;
      tumor_size0_4 = .;
      tumor_size10_14 = .;
      tumor_size15_19 = .;
      tumor_size20_24 = .;
      tumor_size25_29 = .;
      tumor_size30_34 = .;
      tumor_size35_39 = .;
      tumor_size40_44 = .;
      tumor_size45_49 = .;
      tumor_size5_9 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   deg_malig   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_deg_malig  =    -2.78253429049127 +     1.35716746031314 * deg_malig ;
END;
ELSE DO;
   IF MISSING( deg_malig ) THEN S_deg_malig  = . ;
   ELSE S_deg_malig  =    -2.78253429049127 +     1.35716746031314 * deg_malig
         ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -2.74796971637258 * S_deg_malig ;
   H12  =    -1.14470380880618 * S_deg_malig ;
   H13  =    -0.05499579882751 * S_deg_malig ;
   H11  = H11  +    -0.29476277137846 * age20_29  +      -0.010366167334 * 
        age30_39  +    -0.17555609047413 * age40_49  +     0.11413435552706 * 
        age50_59  +    -0.06117744625175 * age60_69  +     -0.5368742297391 * 
        breastleft  +    -0.24218262404951 * breast_quad_
          +     0.06068411466854 * breast_quadcentral
          +     0.97640815123223 * breast_quadleft_low
          +     0.67644175699563 * breast_quadleft_up
          +     0.17789865004419 * breast_quadright_low
          +     2.55134897365733 * inv_nodes0_2  +     0.21424158811054 * 
        inv_nodes12_14  +     0.47820995623683 * inv_nodes15_17
          +      0.2622943817266 * inv_nodes24_26  +     0.12643888087769 * 
        inv_nodes3_5  +     0.84201931474903 * inv_nodes6_8
          +     1.04760396339187 * irradiatno  +     0.07463094979299 * 
        menopausege40  +    -0.44581886051603 * menopauselt40
          +    -0.87854603983125 * node_caps_  +      0.4570771968374 * 
        node_capsno  +     0.37381802079042 * tumor_size0_4
          +     0.85670494080923 * tumor_size10_14  +     0.44903004755901 * 
        tumor_size15_19  +    -0.17074053785079 * tumor_size20_24
          +     0.06170619904789 * tumor_size25_29  +    -0.59125038030471 * 
        tumor_size30_34  +     0.83829482457373 * tumor_size35_39
          +     0.62726406774169 * tumor_size40_44  +     -0.1516346314299 * 
        tumor_size45_49  +     0.52677539133351 * tumor_size5_9 ;
   H12  = H12  +     0.13027205331591 * age20_29  +    -0.06449783231378 * 
        age30_39  +     0.05824555950222 * age40_49  +     0.59985459190818 * 
        age50_59  +    -0.09738234999184 * age60_69  +     -1.1326563834081 * 
        breastleft  +    -0.09133694414179 * breast_quad_
          +     0.28807861638446 * breast_quadcentral
          +     0.59779800988374 * breast_quadleft_low
          +     1.55322081055081 * breast_quadleft_up
          +    -0.90745863860562 * breast_quadright_low
          +      1.5776159015562 * inv_nodes0_2  +    -0.78963665052233 * 
        inv_nodes12_14  +    -0.10914927602566 * inv_nodes15_17
          +      -0.287641916432 * inv_nodes24_26  +    -0.37759361721497 * 
        inv_nodes3_5  +    -0.89487912276378 * inv_nodes6_8
          +      1.2533273720272 * irradiatno  +    -0.50422727076849 * 
        menopausege40  +    -0.63949610800281 * menopauselt40
          +    -0.32842346590983 * node_caps_  +      0.1614812996979 * 
        node_capsno  +     0.15444034413128 * tumor_size0_4
          +     0.28921143447212 * tumor_size10_14  +     0.93609534347786 * 
        tumor_size15_19  +    -0.74160696513512 * tumor_size20_24
          +    -0.19349501615176 * tumor_size25_29  +      0.1936345135719 * 
        tumor_size30_34  +     0.72690837246592 * tumor_size35_39
          +      0.1908875766776 * tumor_size40_44  +    -0.11883017715484 * 
        tumor_size45_49  +    -0.13109284581539 * tumor_size5_9 ;
   H13  = H13  +     0.36211839764495 * age20_29  +     0.84571236618358 * 
        age30_39  +    -0.11526347756118 * age40_49  +    -0.04128901011994 * 
        age50_59  +     1.68133643204135 * age60_69  +     0.00813386538131 * 
        breastleft  +     0.53916416059169 * breast_quad_
          +    -0.08864316260341 * breast_quadcentral
          +     0.82661415499999 * breast_quadleft_low
          +     0.71121038673087 * breast_quadleft_up
          +    -0.82432838124419 * breast_quadright_low
          +     0.17248835987059 * inv_nodes0_2  +     0.64053633216674 * 
        inv_nodes12_14  +     0.46832383814205 * inv_nodes15_17
          +     0.34052933199292 * inv_nodes24_26  +     0.51774207100072 * 
        inv_nodes3_5  +     0.22081734421893 * inv_nodes6_8
          +     0.33158040157428 * irradiatno  +    -0.33994674936188 * 
        menopausege40  +    -0.23106138538014 * menopauselt40
          +    -0.82389546223861 * node_caps_  +    -0.12001895544508 * 
        node_capsno  +    -0.91622770269526 * tumor_size0_4
          +    -2.52443038295481 * tumor_size10_14  +    -1.02411778324248 * 
        tumor_size15_19  +     1.98266427103372 * tumor_size20_24
          +     0.64855674824922 * tumor_size25_29  +     0.40177088900283 * 
        tumor_size30_34  +     -0.3840784388992 * tumor_size35_39
          +    -1.50455217684477 * tumor_size40_44  +     0.95362832752501 * 
        tumor_size45_49  +    -0.76716804997565 * tumor_size5_9 ;
   H11  =     1.16497275748927 + H11 ;
   H12  =     3.06145127542367 + H12 ;
   H13  =     1.14117810063498 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
END;
*** *************************;
*** Writing the Node Class ;
*** *************************;

*** Generate dummy variables for Class ;
drop Classrecurrence_events Classno_recurrence_events ;
label F_Class = 'From: Class' ;
length F_Class $ 20;
F_Class = put( Class , $20. );
%DMNORMIP( F_Class )
if missing( Class ) then do;
   Classrecurrence_events = .;
   Classno_recurrence_events = .;
end;
else do;
   if F_Class = 'NO-RECURRENCE-EVENTS'  then do;
      Classrecurrence_events = 0;
      Classno_recurrence_events = 1;
   end;
   else if F_Class = 'RECURRENCE-EVENTS'  then do;
      Classrecurrence_events = 1;
      Classno_recurrence_events = 0;
   end;
   else do;
      Classrecurrence_events = .;
      Classno_recurrence_events = .;
   end;
end;
IF _DM_BAD EQ 0 THEN DO;
   P_Classrecurrence_events  =    -4.90336136114846 * H11
          +    -13.4892200433884 * H12  +     16.7487792253409 * H13 ;
   P_Classrecurrence_events  =     0.57881101949988 + P_Classrecurrence_events
         ;
   P_Classno_recurrence_events  = 0; 
   _MAX_ = MAX (P_Classrecurrence_events , P_Classno_recurrence_events );
   _SUM_ = 0.; 
   P_Classrecurrence_events  = EXP(P_Classrecurrence_events  - _MAX_);
   _SUM_ = _SUM_ + P_Classrecurrence_events ;
   P_Classno_recurrence_events  = EXP(P_Classno_recurrence_events  - _MAX_);
   _SUM_ = _SUM_ + P_Classno_recurrence_events ;
   P_Classrecurrence_events  = P_Classrecurrence_events  / _SUM_;
   P_Classno_recurrence_events  = P_Classno_recurrence_events  / _SUM_;
END;
ELSE DO;
   P_Classrecurrence_events  = .;
   P_Classno_recurrence_events  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_Classrecurrence_events  =      0.2964824120603;
   P_Classno_recurrence_events  =     0.70351758793969;
END;
*** *****************************;
*** Writing the Residuals  of the Node Class ;
*** ******************************;
IF MISSING( Classrecurrence_events ) THEN R_Classrecurrence_events  = . ;
ELSE R_Classrecurrence_events  = Classrecurrence_events  - 
        P_Classrecurrence_events ;
IF MISSING( Classno_recurrence_events ) THEN R_Classno_recurrence_events
          = . ;
ELSE R_Classno_recurrence_events  = Classno_recurrence_events  - 
        P_Classno_recurrence_events ;
*** *************************;
*** Writing the I_Class  AND U_Class ;
*** *************************;
_MAXP_ = P_Classrecurrence_events ;
I_Class  = "RECURRENCE-EVENTS   " ;
U_Class  = "recurrence-events   " ;
IF( _MAXP_ LT P_Classno_recurrence_events  ) THEN DO; 
   _MAXP_ = P_Classno_recurrence_events ;
   I_Class  = "NO-RECURRENCE-EVENTS" ;
   U_Class  = "no-recurrence-events" ;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
