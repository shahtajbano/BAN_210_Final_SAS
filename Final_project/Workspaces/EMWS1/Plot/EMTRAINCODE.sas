*------------------------------------------------------------* ;
* Plot: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    Class(DESC) age(ASC) breast(ASC) breast_quad(ASC) deg_malig(ASC)
   inv_nodes(ASC) irradiat(ASC) menopause(ASC) node_caps(ASC) tumor_size(ASC)
%mend DMDBClass;
*------------------------------------------------------------*;
* Plot: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=EMWS1.FIMPORT_train
dmdbcat=WORK.Plot_DMDB
maxlevel = 23
nonorm
;
class %DMDBClass;
target
Class
;
run;
quit;
*------------------------------------------------------------*;
* Plot: Creating variable by class target charts;
*------------------------------------------------------------*;
goptions ftext="SWISS";
goptions nodisplay device=PNG;
axis1 width=2 offset=(1,1) label=(rotate=90 angle=270) minor=none;
axis2 width=2 minor=none;
pattern1 value=solid;
proc gchart
data=EMWS1.FIMPORT_train gout=WORK.PlotGRAPH;
*;
title "age by Class";
vbar age /
name = "age            x Class          " description = "age by Class"
FREQ
type=FREQ
subgroup=Class
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "breast by Class";
vbar breast /
name = "breast         x Class          " description = "breast by Class"
FREQ
type=FREQ
subgroup=Class
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "breast_quad by Class";
vbar breast_quad /
name = "breast_quad    x Class          " description = "breast_quad by Class"
FREQ
type=FREQ
subgroup=Class
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "deg_malig by Class";
vbar deg_malig /
name = "deg_malig      x Class          " description = "deg_malig by Class"
FREQ
type=FREQ
subgroup=Class
noframe
missing
discrete
raxis=axis1 maxis=axis2;
run;
title "inv_nodes by Class";
vbar inv_nodes /
name = "inv_nodes      x Class          " description = "inv_nodes by Class"
FREQ
type=FREQ
subgroup=Class
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "irradiat by Class";
vbar irradiat /
name = "irradiat       x Class          " description = "irradiat by Class"
FREQ
type=FREQ
subgroup=Class
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "menopause by Class";
vbar menopause /
name = "menopause      x Class          " description = "menopause by Class"
FREQ
type=FREQ
subgroup=Class
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "node_caps by Class";
vbar node_caps /
name = "node_caps      x Class          " description = "node_caps by Class"
FREQ
type=FREQ
subgroup=Class
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "tumor_size by Class";
vbar tumor_size /
name = "tumor_size     x Class          " description = "tumor_size by Class"
FREQ
type=FREQ
subgroup=Class
noframe
missing
raxis=axis1 maxis=axis2;
run;
quit;
title;
goptions display;
*------------------------------------------------------------*;
* Plot: Copying graphs to node folder;
*------------------------------------------------------------*;
filename gsasfile "C:\Users\shaht\OneDrive\Desktop\Final_project\Workspaces\EMWS1\Plot\GRAPH\age by Class.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay AGE;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\shaht\OneDrive\Desktop\Final_project\Workspaces\EMWS1\Plot\GRAPH\breast by Class.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay BREAST;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\shaht\OneDrive\Desktop\Final_project\Workspaces\EMWS1\Plot\GRAPH\breast_quad by Class.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay BREAST_Q;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\shaht\OneDrive\Desktop\Final_project\Workspaces\EMWS1\Plot\GRAPH\deg_malig by Class.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay DEG_MALI;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\shaht\OneDrive\Desktop\Final_project\Workspaces\EMWS1\Plot\GRAPH\inv_nodes by Class.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay INV_NODE;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\shaht\OneDrive\Desktop\Final_project\Workspaces\EMWS1\Plot\GRAPH\irradiat by Class.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay IRRADIAT;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\shaht\OneDrive\Desktop\Final_project\Workspaces\EMWS1\Plot\GRAPH\menopause by Class.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay MENOPAUS;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\shaht\OneDrive\Desktop\Final_project\Workspaces\EMWS1\Plot\GRAPH\node_caps by Class.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay NODE_CAP;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\shaht\OneDrive\Desktop\Final_project\Workspaces\EMWS1\Plot\GRAPH\tumor_size by Class.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay TUMOR_SI;
quit;
goptions device=win;
filename gsasfile;
