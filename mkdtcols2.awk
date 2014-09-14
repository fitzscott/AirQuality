BEGIN { x=0; }
{
	if (!x++)
		printf("    %s %s", $4, $3);
	else
		printf(",\n    %s %s", $4, $3);
}
END { printf("\n"); }


