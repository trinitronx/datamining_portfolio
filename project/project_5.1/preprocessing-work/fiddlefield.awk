{
  for(i=1;i<=NF;i++) 
    { #### here do particular things to particular fields
      if(i==12)
	{if($i <= 0.3) {$i=0;} else {$i=1;}}
      #### now print the value, whether changed or not

      printf("%s ", $i);
    }
  printf("\n");  #### print end of this line
}

