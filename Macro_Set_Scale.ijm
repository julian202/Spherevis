//create file to store values if none exists: 

	//remove scale:
	run("Set Scale...", "distance=1 known=0 pixel=1 unit=pixel");

	run("Set Measurements...", "  redirect=None decimal=01");
	run("Measure");
    lengthInPixels=getResult("Length");
    
	
	path=getDirectory("imagej")+"\\ValuesSetScale.txt";
	if (File.exists(path)){
	}
	else { 
		File.saveString("Bluray 100", path); //creates empty file;
	}  
	data=File.openAsString(path);
	lines=split(data);
	
	Dialog.create("New Image");
	Dialog.addMessage("Pitch of Bluray is 320nm, DVD is 740nm, SiPattern1 is 540nm, etc..");
	
	labels=newArray("Bluray-320nm", "DVD-740nm","SiPattern1-540nm","SiPatternArash-338nm","GlassPattern1-490nm","Trenches-1060nm","Trenches-1330nm","TrenchesVertical-2160nm");
	
	if (lines[0]=="Bluray-320nm"){
		Dialog.addRadioButtonGroup("Sample: ",labels,3,1,"Bluray-320nm");
	}
	if (lines[0]=="DVD-740nm"){
		Dialog.addRadioButtonGroup("Sample: ",labels,3,1,"DVD-740nm");
	}
	if (lines[0]=="SiPattern1-540nm"){
		Dialog.addRadioButtonGroup("Sample: ",labels,3,1,"SiPattern1-540nm");
	}	
	if (lines[0]=="GlassPattern1-490nm"){
		Dialog.addRadioButtonGroup("Sample: ",labels,3,1,"GlassPattern1-490nm");
	}
	if (lines[0]=="Trenches-1060nm"){
		Dialog.addRadioButtonGroup("Sample: ",labels,3,1,"Trenches-1060nm");
	}
	if (lines[0]=="SiPatternArash-338nm"){
		Dialog.addRadioButtonGroup("Sample: ",labels,3,1,"SiPatternArash-338nm");
	}
	if (lines[0]=="Trenches-1330nm"){
		Dialog.addRadioButtonGroup("Sample: ",labels,3,1,"Trenches-1330nm");
	}
	if (lines[0]=="TrenchesVertical-2160nm"){
		Dialog.addRadioButtonGroup("Sample: ",labels,3,1,"TrenchesVertical-2160nm");
	}
	
	Dialog.addNumber("Number of tracks:", lines[1]);
	
	Dialog.show();
	
	sample=Dialog.getRadioButton();
	
	ntracks = Dialog.getNumber();
	
	if (sample=="Bluray-320nm"){
		pitch=320;
	}
	if (sample=="DVD-740nm"){
		pitch=740;
	}
	if (sample=="SiPattern1-540nm"){
		pitch=540;
	}
	if (sample=="GlassPattern1-490nm"){
		pitch=490;
	}
	if (sample=="Trenches-1060nm"){
		pitch=1060;
	}
	if (sample=="SiPatternArash-338nm"){
		pitch=338;
	}
	if (sample=="Trenches-1330nm"){
		pitch=1330;
	}
	if (sample=="TrenchesVertical-2160nm"){
		pitch=2160;
	}
	
	length=pitch*ntracks;
	
	run("Set Scale...", "known="+length+" unit=nm");

	pixelsperpitch=d2s(lengthInPixels/ntracks, 1);
	String.copy("("+pixelsperpitch+" px per pitch)"); 

	//THIS IS TO SHOW THE MAG IN A MESSAGE BOX: 
	//showMessage("pixels/pitch = "+pixelsperpitch+" copied to system");


	
	//print("pixels/pitch = "+pixelsperpitch+" copied to system");
	toCopy=pixelsperpitch+" px per pitch";
	String.copy(toCopy);
	
	f=File.open(path);
	//showMessage(wToSave+" "+hToSave+" "+dToSave+" "+sToSave+" "+w+" "+h+" "+FWHM);
	print(f,sample+" "+ntracks); 
	File.close(f);
	