BEGIN  {FS = " ";}
{ #### Convert comma separated file to a space separated file
  #### Usage: awk -f ss2cs.awk < dataset.csv > dataset.ss
  for(i=1;i<=NF;i++) { if (i!=NF){ printf("%s,", $i);} else { printf("%s", $i);} }
  printf("\n");
}
