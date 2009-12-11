{  #### Usage: awk -f two-class.awk < dataset.ss > two-class-dataset.ss
  for(i=1;i<=NF;i++) 
    { #### convert the percent crimes per capita field (#128) to
		  #### a 2-class field.
			#### Consider low crime rate to be <= 0.4, and high to be > 0.4
      if(i==NF)
	{if($i <= 0.4) {$i=0;} else {$i=1;}}
      #### now print the new value
      printf("%s ", $i);
    }
  printf("\n");  #### print end of this line
}
