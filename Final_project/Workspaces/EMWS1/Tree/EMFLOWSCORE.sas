****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH F_Class  $   20;
LENGTH I_Class  $   20;
LENGTH U_Class  $   20;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_Classno_recurrence_events = 'Predicted: Class=no-recurrence-events' ;
label P_Classrecurrence_events = 'Predicted: Class=recurrence-events' ;
label Q_Classno_recurrence_events =
'Unadjusted P: Class=no-recurrence-events' ;
label Q_Classrecurrence_events = 'Unadjusted P: Class=recurrence-events' ;
label V_Classno_recurrence_events = 'Validated: Class=no-recurrence-events' ;
label V_Classrecurrence_events = 'Validated: Class=recurrence-events' ;
label R_Classno_recurrence_events = 'Residual: Class=no-recurrence-events' ;
label R_Classrecurrence_events = 'Residual: Class=recurrence-events' ;
label F_Class = 'From: Class' ;
label I_Class = 'Into: Class' ;
label U_Class = 'Unnormalized Into: Class' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_20 $     20; DROP _ARBFMT_20;
_ARBFMT_20 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_5 $      5; DROP _ARBFMT_5;
_ARBFMT_5 = ' '; /* Initialize to avoid warning. */
 
 
_ARBFMT_20 = PUT( Class , $20.);
 %DMNORMCP( _ARBFMT_20, F_Class );
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(deg_malig ) AND
                   2.5 <= deg_malig  THEN DO;
  _ARBFMT_5 = PUT( inv_nodes , $5.);
   %DMNORMIP( _ARBFMT_5);
  IF _ARBFMT_5 IN ('0-2' ,'15-17' ) THEN DO;
    _NODE_  =                    4;
    _LEAF_  =                    2;
    P_Classno_recurrence_events  =     0.54545454545454;
    P_Classrecurrence_events  =     0.45454545454545;
    Q_Classno_recurrence_events  =     0.54545454545454;
    Q_Classrecurrence_events  =     0.45454545454545;
    V_Classno_recurrence_events  =     0.88888888888888;
    V_Classrecurrence_events  =     0.11111111111111;
    I_Class  = 'NO-RECURRENCE-EVENTS' ;
    U_Class  = 'no-recurrence-events' ;
    END;
  ELSE DO;
    _NODE_  =                    5;
    _LEAF_  =                    3;
    P_Classno_recurrence_events  =     0.13333333333333;
    P_Classrecurrence_events  =     0.86666666666666;
    Q_Classno_recurrence_events  =     0.13333333333333;
    Q_Classrecurrence_events  =     0.86666666666666;
    V_Classno_recurrence_events  =     0.35294117647058;
    V_Classrecurrence_events  =     0.64705882352941;
    I_Class  = 'RECURRENCE-EVENTS' ;
    U_Class  = 'recurrence-events' ;
    END;
  END;
ELSE DO;
  _NODE_  =                    2;
  _LEAF_  =                    1;
  P_Classno_recurrence_events  =     0.81428571428571;
  P_Classrecurrence_events  =     0.18571428571428;
  Q_Classno_recurrence_events  =     0.81428571428571;
  Q_Classrecurrence_events  =     0.18571428571428;
  V_Classno_recurrence_events  =     0.77049180327868;
  V_Classrecurrence_events  =     0.22950819672131;
  I_Class  = 'NO-RECURRENCE-EVENTS' ;
  U_Class  = 'no-recurrence-events' ;
  END;
 
*****  RESIDUALS R_ *************;
IF  F_Class  NE 'NO-RECURRENCE-EVENTS'
AND F_Class  NE 'RECURRENCE-EVENTS'  THEN DO;
        R_Classno_recurrence_events  = .;
        R_Classrecurrence_events  = .;
 END;
 ELSE DO;
       R_Classno_recurrence_events  =  -P_Classno_recurrence_events ;
       R_Classrecurrence_events  =  -P_Classrecurrence_events ;
       SELECT( F_Class  );
          WHEN( 'NO-RECURRENCE-EVENTS'  ) R_Classno_recurrence_events  =
        R_Classno_recurrence_events  +1;
          WHEN( 'RECURRENCE-EVENTS'  ) R_Classrecurrence_events  =
        R_Classrecurrence_events  +1;
       END;
 END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
