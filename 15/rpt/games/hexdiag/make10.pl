# from Jack van Rijswijck
# modified to 
#  - ignore commented .hexdiag lines,
#    where a commented line has # as first non-whitespace character
#  - no longer update bounding box modifications for many operations

$arg = shift @ARGV;
$rt3d2 = 0.866025403;
open INFILE, "template10.master.ps";
while (<INFILE>) {$template .= $_;}
$template =~ s/%/%%/g;
$template =~ /HexRadius\s*(\d*)/; $HexRadius = $1;
opendir CURRDIR, ".";
@files = readdir CURRDIR;
while ($filename = shift @files) {
    if ($filename =~ /(.*)\.hexdiag$/) {
        $flat = 0;  # modify in case of FlatTopBoard
        $dimY = 0;  $dimX = 0;
	$diagname = $1;
	printf ("got diagram ($diagname).\n");
	$varlines = "%%---------------- Variables -------------------\n\n";
	$proglines = "%%---------------- Program -------------------\n\n";
	$boundhexleft = 99999;
	$boundhexright = -99999;
	$boundhextop = -99999;
	$boundhexbottom = 99999;
	$boundabsleft = 99999;
	$boundabsright = -99999;
	$boundabstop = -99999;
	$boundabsbottom = 99999;
	$Scale = 1.0;
	$boundingboxline = "";
	$numboundingpieces = 0;
	open INFILE, "$filename";
        while ($line = <INFILE>) {
	    if ($line =~ /^\s*#/) {
	       next; }
	    elsif ($line =~ /BoundingBox\D*(\d*)\D*(\d*)\D*(\d*)\D*(\d*)/i) {
		printf ("ERROR: bounding box specified.\n");
		$boundingboxline = "BoundingBox: $1 $2 $3 $4"; }
	    elsif ($line =~ /OriginX\D*(\d*)/) {
		printf ("ERROR: originX specified.\n");
		$originx = $1;
		$originxline = $line; }
	    elsif ($line =~ /OriginY\D*(\d*)/) {
		printf ("ERROR: originY specified.\n");
		$originy = $1;
		$originyline = $line; }
	    elsif ($line =~ /^\//) {
		$varlines .= $line;
		if ($line =~ /Scale\s+(\S+)/) {
		    $Scale = $1; }
		elsif ($line =~ /DimX\s+(\S+)/) {
		    $dimX = $1; }
		elsif ($line =~ /DimY\s+(\S+)/) {
		    $dimY = $1; }
	    }
	    elsif ($line =~ /(\S+)\s+(\S+).*HexBoundingPiece/) {
		&AddBoundingPiece($1,$2);
		$numboundingpieces++; }
	    else {
		$proglines .= $line;
		&DetectBoundingPiece($line); }
	}
	if ($numboundingpieces>2) {
	    printf ("   $numboundingpieces bounding pieces specified.\n"); }
	elsif ($numboundingpieces==1) {
	    printf ("   1 bounding piece specified.\n"); }
	$proglines =~ s/%/%%/g;
	$minx = (1.5 * $boundhexleft - 1) * $HexRadius * $Scale - 1;
	$maxx = (1.5 * $boundhexright + 1) * $HexRadius * $Scale + 1;
	$miny = $rt3d2*($boundhexbottom - 1) * $HexRadius * $Scale - 1;
	$maxy = $rt3d2*($boundhextop + 1) * $HexRadius * $Scale + 1;
	#$minx = 1.5*$HexRadius*$Scale;
	#$maxx = 1.5*($dimX+$dimY)*$HexRadius*$Scale;
	#$miny = $rt3d2*(1-$dimX)*$HexRadius*$Scale;
	#$maxy = $rt3d2*($dimY-1)*$HexRadius*$Scale;
	if ($boundabsleft * $Scale < $minx) {$minx = $boundabsleft * $Scale;}
	if ($boundabsright * $Scale > $maxx) {$maxx = $boundabsright * $Scale;}
	if ($boundabsbottom * $Scale < $miny) {$miny = $boundabsbottom * $Scale;}
	if ($boundabstop * $Scale > $maxy) {$maxy = $boundabstop * $Scale;}
	if ($flat==1) {
	# assuming HexBoardBorders
	    printf(" flat \n\n");
	    $minx = (1.0)*$HexRadius*$Scale;
	    if ($dimY==0) {$dimY = 0.25+$dimX/2;} # for Y boards
	    $maxx = $rt3d2*(2*$dimY+$dimX+2)*$HexRadius*$Scale;
	    $miny = -(1.5*$dimX)*$HexRadius*$Scale;
	    $maxy = (1.5)*$HexRadius*$Scale;
	    }
        open OUTFILE, ">$diagname.eps";
        printf OUTFILE "%%!PS-Adobe-3.0\n";
	printf OUTFILE "%%%%Creator: Jack van Rijswijck, thanks to Cameron Browne\n";
	printf OUTFILE "%%%%BoundingBox: 0 0 %d %d\n",$maxx-$minx,$maxy-$miny;
	printf OUTFILE "%%%%Pages: 0\n";
	printf OUTFILE "%%%%EndComments\n\n";
	printf OUTFILE "/OriginX %d def\n",-$minx;
	printf OUTFILE "/OriginY %d def\n",-$miny;
	printf OUTFILE "$varlines\n\n";
	printf OUTFILE "$template\n";
	printf OUTFILE "$proglines\n\n";
	if ($arg eq "boxes") {
	    printf OUTFILE ("%d %d %d %d DrawBox\n\n",0,0,$maxx-$minx,$maxy-$miny);
	}
	printf OUTFILE "%%------------ Trailer --------------\n\n";
	printf OUTFILE "showpage\n";
	close OUTFILE;
    }
}
sub AddBoundingPiece {
    if ($_[0]+$_[1] < $boundhexleft) {$boundhexleft = $_[0]+$_[1];}
    if ($_[0]+$_[1] > $boundhexright) {$boundhexright = $_[0]+$_[1];}
    if ($_[1]-$_[0] < $boundhexbottom) {$boundhexbottom = $_[1]-$_[0];}
    if ($_[1]-$_[0] > $boundhextop) {$boundhextop = $_[1]-$_[0];}
}
sub AddBoundingCoordinates {
    if ($_[0] < $boundabsleft) {$boundabsleft = $_[0];}
    if ($_[0] > $boundabsright) {$boundabsright = $_[0];}
    if ($_[1] < $boundabsbottom) {$boundabsbottom = $_[1];}
    if ($_[1] > $boundabstop) {$boundabstop = $_[1];}
}
#sub AddTopLeftTerminal {
    #&AddBoundingPiece(2-($dimY+1)/2-$_[0],($dimY+1)/2);
#}
#sub AddBottomLeftTerminal {
    #&AddBoundingPiece(($dimX+1)/2,2-($dimX+1)/2-$_[0]);
#}
#sub AddTopRightTerminal {
    #&AddBoundingPiece(($dimX+1)/2,$dimX+$dimY-($dimY+1)/2+$_[0]);
#}
#sub AddBottomRightTerminal {
    #&AddBoundingPiece($dimX+$dimY-($dimY+1)/2+$_[0],($dimY+1)/2);
#}

sub DetectBoundingPiece {
    $line = $_[0];
    if ($line =~ /FlatSideCells/ ||
        $line =~ /FlatTopBoard/ ) {
    $flat = 1; }
    elsif ($line =~ /DrawHexBoard/ || 
        $line =~ /NoDrawHexBoard/ || 
	$line =~ /HexShannonGrid/) {
	&AddBoundingPiece(1,1);
	&AddBoundingPiece($dimX,1);
	&AddBoundingPiece(1,$dimY);
	&AddBoundingPiece($dimX,$dimY);
    }
    elsif ($line =~ /DrawHavannahBoard/) {
	&AddBoundingPiece(0.75,($dimX+2)*0.5);
	&AddBoundingPiece($dimX,($dimX+2)*0.5);
	&AddBoundingPiece($dimX,0.75);
	&AddBoundingPiece(0.75,$dimX);
	&AddBoundingPiece(($dimX+1)*0.5,0.75);
	&AddBoundingPiece(($dimX+1)*0.5,$dimX);
    }
    elsif ($line =~ /DrawYBoard/) {
	&AddBoundingPiece(1,1);
	&AddBoundingPiece(1,$dimX);
	&AddBoundingPiece($dimX,1);
    }
    elsif ($line =~ /HexBoardCoordinates/ ||
           $line =~ /HexBoardBorders/) {
	&AddBoundingPiece(0.8,0.8);
	&AddBoundingPiece(0.75,$dimY+0.25);
	&AddBoundingPiece($dimX+0.25,0.75);
	&AddBoundingPiece($dimX+0.2,$dimY+0.2);
    }
    #elsif ($line =~ /(\S+)\s+HexBoardEdgePieces/) {
	#&AddBottomLeftTerminal($1);
	#&AddTopLeftTerminal($1);
	#&AddTopRightTerminal($1);
	#&AddBottomRightTerminal($1);
    #}
    #elsif ($line =~ /(\S+)\s+HexShannonTerminalBottomLeft/ ||
	   #$line =~ /(\S+)\s+HexBoardEdgePieceBottomLeft/) {
	#&AddBottomLeftTerminal($1);
    #}
    #elsif ($line =~ /(\S+)\s+HexShannonTerminalTopLeft/ ||
	   #$line =~ /(\S+)\s+HexBoardEdgePieceTopLeft/) {
	#&AddTopLeftTerminal($1);
    #}
    #elsif ($line =~ /(\S+)\s+HexShannonTerminalTopRight/ ||
	   #$line =~ /(\S+)\s+HexBoardEdgePieceTopRight/) {
	#&AddTopRightTerminal($1);
    #}
    #elsif ($line =~ /(\S+)\s+HexShannonTerminalBottomRight/ ||
	   #$line =~ /(\S+)\s+HexBoardEdgePieceBottomRight/) {
	#&AddBottomRightTerminal($1);
    #}
    #elsif ($line =~ /(\S+)\s+HexShannonTerminalConnectionsBlack/) {
	#&AddTopLeftTerminal($1);
	#&AddBottomRightTerminal($1);
    #}
    #elsif ($line =~ /(\S+)\s+HexShannonTerminalConnectionsWhite/) {
	#&AddTopRightTerminal($1);
	#&AddBottomLeftTerminal($1);
    #}
    #elsif ($line =~ /(\S+)\s+(\S+).*HexagonWithEars/) {
	#&AddBoundingPiece($1+0.5,$2);
	#&AddBoundingPiece($1-0.5,$2);
	#&AddBoundingPiece($1,$2+0.5);
	#&AddBoundingPiece($1,$2-0.5);
	#&AddBoundingPiece($1-0.5,$2+0.5);
	#&AddBoundingPiece($1+0.5,$2-0.5);
    #}
    #elsif ($line =~ /(\S+)\s+(\S+).*HexSymmetricalMoveEval/) {
	#&AddBoundingPiece($1,$2);
	#&AddBoundingPiece(1+$dimX-$1,1+$dimY-$2);
    #}
    #elsif ($line =~ /(\S+)\s+(\S+).*ShadedHexagon/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexMoveEval/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexVertex/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexDot/ ||
	   #$line =~ /(\S+)\s+(\S+).*[^s]LabelString/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexWhitePiece/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexBlackPiece/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexWhiteCapturedPiece/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexBlackCapturedPiece/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexWhiteMarkedPiece/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexBlackMarkedPiece/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexDeadCell/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexDeadMarkedCell/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexDeadPiece/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexDominatedCell/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexWhiteTerminal/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexBlackTerminal/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexWhiteMarker/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexBlackMarker/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexWhiteBlackMarker/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexWhiteLabelledPiece/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexBlackLabelledPiece/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexUpArrow/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexRightArrow/ ||
	   #$line =~ /(\S+)\s+(\S+).*HexLeftArrow/) {
	#&AddBoundingPiece($1,$2);
    #}
    #elsif ($line =~ /(\S+)\s+(\S+).*AbsDot/ ||
	   #$line =~ /(\S+)\s+(\S+).*AbsLabelString/ ||
	   #$line =~ /(\S+)\s+(\S+).*AbsVertex/) {
##	&AddBoundingCoordinates($1,$2);
    #}
    #elsif ($line =~ /(\S+)\s+(\S+)\s+(\S+)\s+(\S+).*AbsLine/) {
	#&AddBoundingCoordinates($1,$2);
	#&AddBoundingCoordinates($3,$4);
    #}
    elsif ($line =~ /HexLine/ ||
	   $line =~ /FontSelect/ ||
	   $line =~ /setgray/ ||
	   $line =~ /newpath/ ||
	   $line =~ /rlineto/ ||
	   $line =~ /moveto/ ||
	   $line =~ /setlinewidth/ ||
	   $line =~ /stroke/) {
	## niks. (bij hexline zal toch wel een vertex of piece horen).
    }
    elsif ($line =~ /\S/) {
	printf ("unparsed line $line");
    }
}

