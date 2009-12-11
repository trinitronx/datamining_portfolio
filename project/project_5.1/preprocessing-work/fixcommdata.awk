BEGIN {records = 0; numfields = 128;}
{
  records++;
  for(i=1;i<=NF;i++)
    {data[records,i] = $i;}
}
END {
##### initialise missing value counts 
  for(i=1;i<=numfields;i++) {miss[i] = 0;}
##### count missing values 
 for(r=1;r<=records;r++)
  { for(f=1;f<=numfields;f++)
     { if(data[r,f]=="?") {miss[f]++;}}
 }
#####   now print only the predictive fields, and ignore
#####   fields that have any missing values 
  for(r=1;r<=records;r++)
    { ##### start at field 6 because fields 1--5 are not 
      #####  predictive in this dataset -- just info 
     for(f=6;f<=numfields;f++)
       {if(miss[f]>0) {continue;}
	 printf("%s ", data[r,f]);
       }
      printf("\n");  ##### end this line 
    }
}