BEGIN { x=0; }
{
for (c = 1; c <= NF; c++)
	{
	    if (!x++)
		printf("    %s STRING", tolower($c));
	    else
		printf(",\n    %s STRING", tolower($c));
	}
}
END { printf("\n"); }

