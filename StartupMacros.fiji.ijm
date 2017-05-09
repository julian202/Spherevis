// "StartupMacros"
// The macros and macro tools in this file ("StartupMacros.txt") are
// automatically installed in the Plugins>Macros submenu and
//  in the tool bar when ImageJ starts up.

//  About the drawing tools.
//
//  This is a set of drawing tools similar to the pencil, paintbrush,
//  eraser and flood fill (paint bucket) tools in NIH Image. The
//  pencil and paintbrush draw in the current foreground color
//  and the eraser draws in the current background color. The
//  flood fill tool fills the selected area using the foreground color.
//  Hold down the alt key to have the pencil and paintbrush draw
//  using the background color or to have the flood fill tool fill
//  using the background color. Set the foreground and background
//  colors by double-clicking on the flood fill tool or on the eye
//  dropper tool.  Double-click on the pencil, paintbrush or eraser
//  tool  to set the drawing width for that tool.
//
// Icons contributed by Tony Collins.



// Global variables
var pencilWidth=1,  eraserWidth=10, leftClick=16, alt=8;
var brushWidth = 10; //call("ij.Prefs.get", "startup.brush", "10");
var floodType =  "8-connected"; //call("ij.Prefs.get", "startup.flood", "8-connected");

// The macro named "AutoRunAndHide" runs when ImageJ starts
// and the file containing it is not displayed when ImageJ opens it.

// macro "AutoRunAndHide" {}

function UseHEFT {
	requires("1.38f");
	state = call("ij.io.Opener.getOpenUsingPlugins");
	if (state=="false") {
		setOption("OpenUsingPlugins", true);
		showStatus("TRUE (images opened by HandleExtraFileTypes)");
	} else {
		setOption("OpenUsingPlugins", false);
		showStatus("FALSE (images opened by ImageJ)");
	}
}

UseHEFT();

// The macro named "AutoRun" runs when ImageJ starts.

macro "AutoRun" {
	// run all the .ijm scripts provided in macros/AutoRun/
	autoRunDirectory = getDirectory("imagej") + "/macros/AutoRun/";
	if (File.isDirectory(autoRunDirectory)) {
		list = getFileList(autoRunDirectory);
		// make sure startup order is consistent
		Array.sort(list);
		for (i = 0; i < list.length; i++) {
			if (endsWith(list[i], ".ijm")) {
				runMacro(autoRunDirectory + list[i]);
			}
		}
	}
}

var pmCmds = newMenu("Popup Menu",
	newArray("Help...", "Rename...", "Duplicate...", "Original Scale",
	"Paste Control...", "-", "Record...", "Capture Screen ", "Monitor Memory...",
	"Find Commands...", "Control Panel...", "Startup Macros...", "Search..."));

macro "Popup Menu" {
	cmd = getArgument();
	if (cmd=="Help...")
		showMessage("About Popup Menu",
			"To customize this menu, edit the line that starts with\n\"var pmCmds\" in ImageJ/macros/StartupMacros.txt.");
	else
		run(cmd);
}

macro "Abort Macro or Plugin (or press Esc key) Action Tool - CbooP51b1f5fbbf5f1b15510T5c10X" {
	setKeyDown("Esc");
}

var xx = requires138b(); // check version at install
function requires138b() {requires("1.38b"); return 0; }

var dCmds = newMenu("Developer Menu Tool",
newArray("ImageJ Website","News", "Documentation", "ImageJ Wiki", "Resources", "Macro Language", "Macros",
	"Macro Functions", "Startup Macros...", "Plugins", "Source Code", "Mailing List Archives", "-", "Record...",
	"Capture Screen ", "Monitor Memory...", "List Commands...", "Control Panel...", "Search...", "Debug Mode"));


macro "Close All Images and Windows Macro Action Tool - C037T0b11CT7b09LTcb09A" {
	setBatchMode(true); 
	a=getList("window.titles");
	for (i=0;i<a.length;i++){
		selectWindow(a[i]);
		run("Close");
	}	
	run("Close All");
	setBatchMode(false); 
}

/*options:
Bxy	set base location (default is 0,0)
Crgb	set color
Dxy	draw dot
Fxywh	draw filled rectangle
Gxyxy...xy00	draw polygon (requires 1.48j)
Hxyxy...xy00	draw filled polygon (requires 1.48k)
Lxyxy	draw line
Oxywh	draw oval
Pxyxy...xy0	draw polyline
Rxywh	draw rectangle
Txyssc	draw character (x and y is position in hex 0-15, ss is font size in decimal, c is character in ASCII)
Vxywh	draw filled oval (requires 1.48j)
Where x (x coordinate), y (y coodinate), w (width), h (height), r (red), g (green) and b (blue)
are lower case hex digits that specify a values in the range 0-15.
When drawing a character (T), ss is the decimal font size in points (e.g., 14) and c is an ASCII character.*/


macro "Close All Images Macro Action Tool - C037T0b11CT7b09LTcb09I" {
	run("Close All");
}

macro "Images To Stack Macro Action Tool - C037T0b11IT3b08mTab09>Tfb09S" {
	run("Images to Stack", "name=Stack title=[] use");	
}

macro "Brightness/Contrast Macro Action Tool - C037T0b11BT7b09/Tcb09C" {
	run("Brightness/Contrast...");
}


macro "Save as Tiff.. Macro Action Tool - C037T0509ST5509aT7509vTc509eT0f09TT6f09iTbf09fTff09f" {
	saveAs("Tiff");
}


macro "Line Width Macro Action Tool - C037T0509LT5509iT7509nTc509eT0f09wT6f09dTbf09tTff09h" {
	run("Line Width...");
}

macro "Set Color to White Macro Action Tool - C037T0b11WTcb09C" {
	run("Colors...", "foreground=white background=black selection=cyan");
}
macro "Set Color to Black Macro Action Tool - C037T0b11BTcb09C" {
	run("Colors...", "foreground=black background=black selection=cyan");
}


macro "Resize 800 Macro Action Tool - C037T0f091T5f098Tff090T7509R" {
	run("Size...", "width=800 height=642 constrain average interpolation=Bilinear");
}

macro "Smooth 5 times Macro Action Tool - C037T0f09ST5f09mTcf09tTff09hT75095" {
	for (i=0; i<5; i++) {
		run("Smooth");
	}
	setTool("line");
}





macro "Set Scale Macro Action Tool - C037T0f11ST7f09eTcf09tT8509[Tb509sTf509]" {
	runMacro("Macro_Set_Scale");
}

macro "Macro Set_Scale [s]" { 
	runMacro("Macro_Set_Scale");
	//run("Set Scale...", "distance=797.1073 known=50 pixel=1 unit=um");
	//showMessage("done");
	
}

macro "Black Arrow Macro Action Tool - C037T0f11BT5f09bTcf09aT8509" {
setForegroundColor(0, 0, 0);
setTool("arrow");
}



macro "Macro Duplicate-Resize160-Copy" { 
	  myfuncDRC();
}
function myfuncDRC() {
	run("Duplicate...", " ");
	run("Size...", "width=160 height=120 constrain average interpolation=Bilinear");
	run("Copy to System");
	close(); 
}



var mCmds = newMenu("Julian Menu Tool",
	newArray("Duplicate,Resize160,Copy [j]"));
macro "Julian Menu Tool - C037T0b11JT8b09uTeb09l" {
	cmd = getArgument();
	if (cmd=="Duplicate,Resize160,Copy [j]") {
		myfuncDRC(); //this function is also called in in the macro "Duplicate,Resize160,Copy"
	}
}
macro "Macro myfuncDRC() [j]" { 
	myfuncDRC();
}



var scCmds = newMenu("Set Scale Menu Tool",
	newArray("DaeyeonZeiss100xNewCam4096px","DaeyeonZeiss63xNewCam4096px","DaeyeonZeiss20xNewCam4096px","DaeyeonZeiss20xOldCam","CoreLeica5x1.6mag","CoreLeica20x1.6mag","CoreLeica63x1.6mag","Wells20x0.4-2Mag","Wells20x0.5-2Mag","Wells40x0.75-2Mag","Wells50x0.55-2Mag"));
macro "Set Scale Menu Tool - C037T0b11ST8b09cTeb09l" {
	cmd = getArgument();
	if (cmd=="DaeyeonZeiss63xNewCam4096px") {
		run("Set Scale...", "distance=2146.8271 known=50 pixel=1 unit=um");		
	}
	if (cmd=="DaeyeonZeiss20xOldCam") {
		run("Set Scale...", "distance=1237.3136 known=200 pixel=1 unit=um");		
	}
	if (cmd=="CoreLeica5x1.6mag") {
		run("Set Scale...", "distance=372.1025 known=300 pixel=1 unit=um");		
	}	
	if (cmd=="CoreLeica20x1.6mag") {
		run("Set Scale...", "distance=347.0357 known=68.90 pixel=1 unit=um");		
	}
	if (cmd=="CoreLeica63x1.6mag") {
		run("Set Scale...", "distance=1082.0906 known=68.9 pixel=1 unit=um");		
	}
	if (cmd=="DaeyeonZeiss20xNewCam4096px") {
		run("Set Scale...", "distance=2849.8737 known=200 pixel=1 unit=µm");
	}
	if (cmd=="DaeyeonZeiss100xNewCam4096px") {
		run("Set Scale...", "distance=49.02121 known=689 pixel=1 unit=nm");		
	}
	if (cmd=="Wells20x0.4-2Mag") {
		run("Set Scale...", "distance=634.9110 known=100 pixel=1 unit=um");
	}
	if (cmd=="Wells20x0.5-2Mag") {
		run("Set Scale...", "distance=631.3493 known=100 pixel=1 unit=um");
	}
	if (cmd=="Wells40x0.75-2Mag") {
		run("Set Scale...", "distance=634.8071 known=50 pixel=1 unit=um");
	}
	if (cmd=="Wells50x0.55-2Mag") {
		run("Set Scale...", "distance=797.1073 known=50 pixel=1 unit=um");
	}
	
	
	setTool("line");

}

macro "Find FWHM of Maximum Macro Action Tool - C037T0f09FT5f09wTcf09hTff09mT4509[T9509fTf509]" {
	runMacro("Macro_ProfileFinal-1maxSlope");   
}






///////////////////////////////////////////////////////////////////////////////////
/// limit of imagej window width reached here
///////////////////////////////////////////////



macro "Close All Windows Macro Action Tool - C037T0b11CT7b09LTcb09W" {
	a=getList("window.titles");
	for (i=0;i<a.length;i++){
		selectWindow(a[i]);
		run("Close");
	}	
}

macro "Invert Line Macro Action Tool - C037T0f11IT5f09nTcf09vT8509[Tb509iTf509]" {
	getLine(x1, y1, x2, y2, lineWidth);
	run("Select None");
	makeLine(x2, y2, x1, y1);
}
macro "Invert Line Macro [i]" { 
	getLine(x1, y1, x2, y2, lineWidth);
	run("Select None");
	makeLine(x2, y2, x1, y1);
}


macro "Smooth 10 times Macro Action Tool - C037T0f09ST5f09mTcf09tTff09hT4509[T7509mTf509]" {
	for (i=0; i<10; i++) {
		run("Smooth");
	}
	setTool("line");
}


macro "Split colors Macro Action Tool - C037T0a09ST5a09pTaa09lTda09iTfa09t" {
	a=getTitle();
	run("Split Channels");	
	selectWindow(a+" (green)");
	setTool("rectangle"); 
}

macro "Gray LUT Macro Action Tool - C037T0b11GT7b09rTcb09y" {
	run("Grays");	
}



macro "Convert to RGB Macro Action Tool - C037T0509TT4509oT9509[Tc509tTf509]T0f09RT7f09GTff09B" {
	run("RGB Color");
}

macro "Macro toRGB() [T]" { //Same as previous macro but this allows me to use keypress t
	run("RGB Color");
}

macro "Resize Image to 160 pixels Macro Action Tool - C037T0509RT5509ZT0f071T4f076T8f070" {
	run("Size...", "width=160 height=120 constrain average interpolation=Bilinear");
}
/*
macro "Resize Image to 320 pixels Macro Action Tool - C037T0509RT5509ZT0f073T4f072T8f070" {
	run("Size...", "width=320 height=240 constrain average interpolation=Bilinear");
}*/



macro "Set Preferred Scale DaeyeonZeiss20xNewCam4096p Macro Action Tool - C037T0f11PT8509[Ta509pTf509]" {
	//"DaeyeonZeiss20xNewCam4096px"
	run("Set Scale...", "distance=2849.8737 known=200 pixel=1 unit=µm");
}

macro "Remove Scale Macro Action Tool - C037T0b11RT7b09mTcb09S" {
	run("Set Scale...", "distance=1 known=1 unit=unit");
}


macro "Show Horizontal Scaled Length of Line Selection Macro Action Tool - C037T0509HT5509oT9509rTc509iTf509zT0f09lT2f09eT6f09nTbf09gTff09t" {
	runMacro("GetHorizLength");
}

macro "Developer Menu Tool - C037T0b11DT7b09eTcb09v" {
	cmd = getArgument();
	if (cmd=="ImageJ Website")
		run("URL...", "url=http://rsbweb.nih.gov/ij/");
	else if (cmd=="News")
		run("URL...", "url=http://rsbweb.nih.gov/ij/notes.html");
	else if (cmd=="Documentation")
		run("URL...", "url=http://rsbweb.nih.gov/ij/docs/");
	else if (cmd=="ImageJ Wiki")
		run("URL...", "url=http://imagejdocu.tudor.lu/imagej-documentation-wiki/");
	else if (cmd=="Resources")
		run("URL...", "url=http://rsbweb.nih.gov/ij/developer/");
	else if (cmd=="Macro Language")
		run("URL...", "url=http://rsbweb.nih.gov/ij/developer/macro/macros.html");
	else if (cmd=="Macros")
		run("URL...", "url=http://rsbweb.nih.gov/ij/macros/");
	else if (cmd=="Macro Functions")
		run("URL...", "url=http://rsbweb.nih.gov/ij/developer/macro/functions.html");
	else if (cmd=="Plugins")
		run("URL...", "url=http://rsbweb.nih.gov/ij/plugins/");
	else if (cmd=="Source Code")
		run("URL...", "url=http://rsbweb.nih.gov/ij/developer/source/");
	else if (cmd=="Mailing List Archives")
		run("URL...", "url=https://list.nih.gov/archives/imagej.html");
	else if (cmd=="Debug Mode")
		setOption("DebugMode", true);
	else if (cmd!="-")
		run(cmd);
}



var sCmds = newMenu("Stacks Menu Tool",
	newArray("Add Slice", "Delete Slice", "Next Slice [>]", "Previous Slice [<]", "Set Slice...", "-",
		"Convert Images to Stack", "Convert Stack to Images", "Make Montage...", "Reslice [/]...", "Z Project...",
		"3D Project...", "Plot Z-axis Profile", "-", "Start Animation", "Stop Animation", "Animation Options...",
		"-", "MRI Stack (528K)"));
macro "Stacks Menu Tool - C037T0b11ST8b09tTcb09k" {
	cmd = getArgument();
	if (cmd!="-") run(cmd);
}

var luts = getLutMenu();
var lCmds = newMenu("LUT Menu Tool", luts);
macro "LUT Menu Tool - C037T0b11LT6b09UTcb09T" {
	cmd = getArgument();
	if (cmd!="-") run(cmd);
}
function getLutMenu() {
	list = getLutList();
	menu = newArray(16+list.length);
	menu[0] = "Invert LUT"; menu[1] = "Apply LUT"; menu[2] = "-";
	menu[3] = "Fire"; menu[4] = "Grays"; menu[5] = "Ice";
	menu[6] = "Spectrum"; menu[7] = "3-3-2 RGB"; menu[8] = "Red";
	menu[9] = "Green"; menu[10] = "Blue"; menu[11] = "Cyan";
	menu[12] = "Magenta"; menu[13] = "Yellow"; menu[14] = "Red/Green";
	menu[15] = "-";
	for (i=0; i<list.length; i++)
		menu[i+16] = list[i];
	return menu;
}

function getLutList() {
	lutdir = getDirectory("luts");
	list = newArray("No LUTs in /ImageJ/luts");
	if (!File.exists(lutdir))
		return list;
	rawlist = getFileList(lutdir);
	if (rawlist.length==0)
		return list;
	count = 0;
	for (i=0; i< rawlist.length; i++)
		if (endsWith(rawlist[i], ".lut")) count++;
	if (count==0)
		return list;
	list = newArray(count);
	index = 0;
	for (i=0; i< rawlist.length; i++) {
		if (endsWith(rawlist[i], ".lut"))
			list[index++] = substring(rawlist[i], 0, lengthOf(rawlist[i])-4);
	}
	return list;
}

macro "Pencil Tool - C037L494fL4990L90b0Lc1c3L82a4Lb58bL7c4fDb4L5a5dL6b6cD7b" {
	getCursorLoc(x, y, z, flags);
	if (flags&alt!=0)
		setColorToBackgound();
	draw(pencilWidth);
}

macro "Paintbrush Tool - C037La077Ld098L6859L4a2fL2f4fL3f99L5e9bL9b98L6888L5e8dL888c" {
	getCursorLoc(x, y, z, flags);
	if (flags&alt!=0)
		setColorToBackgound();
	draw(brushWidth);
}

macro "Flood Fill Tool -C037B21P085373b75d0L4d1aL3135L4050L6166D57D77D68La5adLb6bcD09D94" {
	requires("1.34j");
	setupUndo();
	getCursorLoc(x, y, z, flags);
	if (flags&alt!=0) setColorToBackgound();
	floodFill(x, y, floodType);
}

function draw(width) {
	requires("1.32g");
	setupUndo();
	getCursorLoc(x, y, z, flags);
	setLineWidth(width);
	moveTo(x,y);
	x2=-1; y2=-1;
	while (true) {
		getCursorLoc(x, y, z, flags);
		if (flags&leftClick==0) exit();
		if (x!=x2 || y!=y2)
			lineTo(x,y);
		x2=x; y2 =y;
		wait(10);
	}
}

function setColorToBackgound() {
	savep = getPixel(0, 0);
	makeRectangle(0, 0, 1, 1);
	run("Clear");
	background = getPixel(0, 0);
	run("Select None");
	setPixel(0, 0, savep);
	setColor(background);
}

// Runs when the user double-clicks on the pencil tool icon
macro 'Pencil Tool Options...' {
	pencilWidth = getNumber("Pencil Width (pixels):", pencilWidth);
}

// Runs when the user double-clicks on the paint brush tool icon
macro 'Paintbrush Tool Options...' {
	brushWidth = getNumber("Brush Width (pixels):", brushWidth);
	call("ij.Prefs.set", "startup.brush", brushWidth);
}

// Runs when the user double-clicks on the flood fill tool icon
macro 'Flood Fill Tool Options...' {
	Dialog.create("Flood Fill Tool");
	Dialog.addChoice("Flood Type:", newArray("4-connected", "8-connected"), floodType);
	Dialog.show();
	floodType = Dialog.getChoice();
	call("ij.Prefs.set", "startup.flood", floodType);
}

macro "Set Drawing Color..."{
	run("Color Picker...");
}

macro "-" {} //menu divider

macro "About Startup Macros..." {
	title = "About Startup Macros";
	text = "Macros, such as this one, contained in a file named\n"
		+ "'StartupMacros.txt', located in the 'macros' folder inside the\n"
		+ "Fiji folder, are automatically installed in the Plugins>Macros\n"
		+ "menu when Fiji starts.\n"
		+ "\n"
		+ "More information is available at:\n"
		+ "<http://imagej.nih.gov/ij/developer/macro/macros.html>";
	dummy = call("fiji.FijiTools.openEditor", title, text);
}
/*
macro "Save As JPEG... [j]" {
	quality = call("ij.plugin.JpegWriter.getQuality");
	quality = getNumber("JPEG quality (0-100):", quality);
	run("Input/Output...", "jpeg="+quality);
	saveAs("Jpeg");
}*/

macro "Save Inverted FITS" {
	run("Flip Vertically");
	run("FITS...", "");
	run("Flip Vertically");
}


macro "Macro getLineLength [f]" { 
	a=getTitle();
	runMacro("Macro_ProfileFinal-1maxSlope");
	
	//showMessage("Press ctr-z to undo draw");
	selectWindow(a);
    //run("Draw", "slice");
    
}
//macro "Macro Circle [h]" { 
	//runMacro("MacroDrawCircle");
//}

//macro "Macro runGetHorizLength [h]" { 
//	runMacro("GetHorizLength");   
//}

macro "Macro myfuncDRC() [r]" { 
	setTool("rectangle"); 
}

macro "Macro myfuncDRC() [l]" { 
	setTool("line"); 
}
//macro "Macro Visibility [v]" { 
//	runMacro("Macro_Visibility_Normalized_Auto");
//}
macro "Macro Duplicate [d]" { 
	run("Duplicate...", " ");
	setTool("line");
}
macro "Macro Duplicate [t]" { 
setTool("text");
}


macro "Macro 2PointMeasure-Horizontal [h]" { 
	runMacro("Macro_2PointMeasure-Horizontal");
	
}

macro "Macro 2PointMeasure-Vertical [v]" { 
	runMacro("Macro_2PointMeasure-Vertical");
}

macro "Macro AutoVisibility [6]" { 
	runMacro("Macro_Visibility-PluginTest");
}


macro "Macro Custom [p]" { 
	//setTool("multipoint");
	
	setTool("line");
	makeRectangle(1572, 1914, 1098, 1104);

}


macro "Macro 2PointMeasure " { 
	
	runMacro("Macro_MultiPointMeasure");
	//runMacro("Macro_2PointMeasure");
	//runMacro("Macro_2PointMeasure-Horizontal");
	//runMacro("Macro_2PoinProfile");	
}

macro "Macro measure line Length [g]" { //Same as previous macro but this allows me to use keypress t
	//Scale DaeyeonZeiss63xNewCam4096px
	run("Set Scale...", "distance=2146.8271 known=50 pixel=1 unit=um");	
	runMacro("Measure_Line_Length");
}

macro "Macro smooth [m]" { //Same as previous macro but this allows me to use keypress t
	for (i=0; i<5; i++) {
		run("Smooth");
	}
	setTool("line");
}

macro "Macro Custom [n]" { 
	
	//Scale DaeyeonZeiss63xNewCam4096px
	run("Set Scale...", "distance=2146.8271 known=50 pixel=1 unit=um");	
	//setForegroundColor(0, 0, 0);
	//setTool("arrow");
	
	/*
	roiManager("reset");
	roiManager("add");	
	for (i=0; i<5; i++) {
		run("Smooth");
	}
	roiManager("Select", 0);
	setTool("multipoint");
	run("Plot Profile");
	*/
	//showMessage("done");
}

macro "Macro Custom2 [e]" { 
	//Scale DaeyeonZeiss63xNewCam4096px
	run("Set Scale...", "distance=2146.8271 known=50 pixel=1 unit=um");	
	setTool("line");
	
	//Scale DaeyeonZeiss20xNewCam4096p
	//run("Set Scale...", "distance=2849.8737 known=200 pixel=1 unit=µm");
	//runMacro("Macro_2PoinProfile");
	//setTool("multipoint");
	
	
	//runMacro("Macro_2PointMeasure");
}

