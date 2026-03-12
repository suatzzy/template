DO AS FOLLOWING:

modify the absolute paths in mk_ic_proj.sh

enter the directory you want to establish a project:

\<where mk_ic_proj.sh belongs\>./mk_ic_proj.sh  \<YOUR PROJECT NAME\>

cd \<your new prject\>

fill in  rtl/ and tb/  with your codes

cd sim

ls ../rtl/* > rtl.f

ls ../tb/* >> files.f

make lint TOP_MODULE=\<the submodule you want to lint\>

make all

make verdi

