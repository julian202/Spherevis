
	getLine(x1, y1, x2, y2, lineWidth);
	toScaled(x1);
	toScaled(y1);
	toScaled(x2);
	toScaled(y2);
	//print(x1+","+y1+" "+x2+","+y2);
	
	//len=abs(parseInt(x2-x1));
	len=sqrt(pow(x2-x1,2)+pow(y2-y1,2));
	len=d2s(len, 1)
	String.copy(len);
	//showMessage(len + " copied to system");