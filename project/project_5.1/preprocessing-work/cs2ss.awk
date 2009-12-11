BEGIN  {FS = ",";}
{ #### Convert comma separated file to a space separated file
  #### Usage: awk -f cs2ss.awk < dataset.csv > dataset.ss
  for(i=1;i<=NF;i++) {printf("%s ", $i);}
  printf("\n");
}
