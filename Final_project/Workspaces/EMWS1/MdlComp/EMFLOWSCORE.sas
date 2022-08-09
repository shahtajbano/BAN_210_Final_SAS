drop _temp_;
if (P_Classrecurrence_events ge 0.99997423993044) then do;
b_Class = 1;
end;
else
if (P_Classrecurrence_events ge 0.98082907003633) then do;
b_Class = 2;
end;
else
if (P_Classrecurrence_events ge 0.68861826642603) then do;
b_Class = 3;
end;
else
if (P_Classrecurrence_events ge 0.32517894111538) then do;
b_Class = 4;
end;
else
if (P_Classrecurrence_events ge 0.28075396969449) then do;
b_Class = 5;
end;
else
if (P_Classrecurrence_events ge 0.26028861145292) then do;
b_Class = 6;
end;
else
if (P_Classrecurrence_events ge 0.25631102063238) then do;
b_Class = 7;
end;
else
if (P_Classrecurrence_events ge 0.25544447039289) then do;
b_Class = 8;
end;
else
if (P_Classrecurrence_events ge 0.25314992106194) then do;
b_Class = 9;
end;
else
if (P_Classrecurrence_events ge 0.24850889141301) then do;
b_Class = 10;
end;
else
if (P_Classrecurrence_events ge 0.23604992678102) then do;
b_Class = 11;
end;
else
if (P_Classrecurrence_events ge 0.22465606910278) then do;
b_Class = 12;
end;
else
if (P_Classrecurrence_events ge 0.19365094547494) then do;
b_Class = 13;
end;
else
if (P_Classrecurrence_events ge 0.12838285328328) then do;
b_Class = 14;
end;
else
if (P_Classrecurrence_events ge 0.05511773177) then do;
b_Class = 15;
end;
else
if (P_Classrecurrence_events ge 0.01516070638852) then do;
b_Class = 16;
end;
else
if (P_Classrecurrence_events ge 0.00189560571317) then do;
b_Class = 17;
end;
else
if (P_Classrecurrence_events ge 1.5301246853945E-6) then do;
b_Class = 18;
end;
else
do;
_temp_ = dmran(1234);
b_Class = floor(19 + 2*_temp_);
end;
