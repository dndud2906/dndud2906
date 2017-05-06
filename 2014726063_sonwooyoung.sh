#! /bin/bash

project_first()			
{
	echo "=== print file information ==="
	echo "current directory : `pwd`"	
	echo "the number of elements : `ls | wc -l`"		
}

func_directory() 
{
local name=$1
echo -e "\033[34m"file type : 디렉토리"\033[0m"
echo "file size : `stat ${name} | grep "Size" | cut -c 9-12`"
echo "modified time : `stat ${name} | grep "Modify" | cut -c 9-45`"
echo "permisson : `stat ${name} | grep "Uid" | cut -c 11-13`"
echo "absolute path : `pwd ${name}`/${name}"
echo "relative path : ./${name}"
echo "-----------------------------------------------"
}

func_directory2() 
{
local name=$1
echo -e "\t\033[34m"file type : 디렉토리"\033[0m"
echo -e "\tfile size : `stat ${name} | grep "Size" | cut -c 9-12`"
echo -e "\tmodified time : `stat ${name} | grep "Modify" | cut -c 9-45`"
echo -e "\tpermisson : `stat ${name} | grep "Uid" | cut -c 11-13`"
echo -e "\tabsolute path : `pwd ${name}`/${name}"
echo -e "\trelative path : ./${name}"
echo -e "\t-----------------------------------------------"
}


func_file()
{
local name=$1
echo -e "file type : 일반파일"
echo "file size : `stat ${name} | grep "Size" | cut -c 9-12`"
echo "modified time : `stat ${name} | grep "Modify" | cut -c 9-45`"
echo "permisson : `stat ${name} | grep "Uid" | cut -c 11-13`"
echo "absolute path : `pwd ${name}`/${name}"
echo "relative path : ./${name}"
echo "-----------------------------------------------"
}

func_file2()
{
local name=$1
echo -e "\tfile type : 일반파일"
echo -e "\tfile size : `stat ${name} | grep "Size" | cut -c 9-12`"
echo -e "\tmodified time : `stat ${name} | grep "Modify" | cut -c 9-45`"
echo -e "\tpermisson : `stat ${name} | grep "Uid" | cut -c 11-13`"
echo -e "\tabsolute path : `pwd ${name}`/${name}"
echo -e "\trelative path : ./${name}"
echo -e "\t-----------------------------------------------"
}


func_special()
{
local name=$1
echo -e "\033[36m"file type : FIFO"\033[0m"
echo "file size : `stat ${name} | grep "Size" | cut -c 9-12`"
echo "modified time : `stat ${name} | grep "Modify" | cut -c 9-45`"
echo "permisson : `stat ${name} | grep "Uid" | cut -c 11-13`"
echo "absolute path : `pwd ${name}`/${name}"
echo "relative path : ./${name}"
echo "-----------------------------------------------"
}

func_special2()
{
local name=$1
echo -e "\t\033[36m"file type : FIFO"\033[0m"
echo -e "\tfile size : `stat ${name} | grep "Size" | cut -c 9-12`"
echo -e "\tmodified time : `stat ${name} | grep "Modify" | cut -c 9-45`"
echo -e "\tpermisson : `stat ${name} | grep "Uid" | cut -c 11-13`"
echo -e "\tabsolute path : `pwd ${name}`/${name}"
echo -e "\trelative path : ./${name}"
echo -e "\t-----------------------------------------------"
}


project_second()
{
	i=1
	for name in *
	do	
	   if [[ `ls -dl ${name} | cut -c 1` = "d" ]]
	   then
		echo "[$i]  ${name}"
		echo "------------------INFORMATION------------------"
			func_directory $name
		j=1
		for filename in `ls ${name} | sort`
		do
		  if [[ `ls -dl ${name}/${filename} | cut -c 1` = "d" ]]
		  then
			echo -e "\t[$j]  ${name}/${filename}"
			echo -e "\t------------------INFORMATION------------------"
				func_directory2 $name/$filename
			j=`expr $j + 1`
		  fi
		done
                for filename in `ls ${name} | sort`
                do
                  if [[ `ls -dl ${name}/${filename} | cut -c 1` = "-" ]]
                  then
                        echo -e "\t[$j]  ${name}/${filename}"
                        echo -e "\t------------------INFORMATION------------------"
                                func_file2 $name/$filename
                        j=`expr $j + 1`
                  fi
                done
                for filename in `ls ${name} | sort`
                do
                  if [[ `ls -dl ${name}/${filename} | cut -c 1` != "d" && `ls -dl ${name}/${filename} | cut -c 1` != "-" ]]
                  then
                        echo -e "\t[$j]  ${name}/${filename}"
                        echo -e "\t------------------INFORMATION------------------"
                                func_special2 $name/$filename
                        j=`expr $j + 1`
                  fi
                done


	   fi
	   if [[ `ls -dl ${name} | cut -c 1` = "d" ]]
	   then
		i=`expr $i + 1`
	   fi
	done

	for name in *
	do	

	   if [[ `ls -dl ${name} | cut -c 1` = "-" ]]
		then
		echo "[$i]  ${name}"
		echo "------------------INFORMATION------------------"
			func_file $name
	   fi
	   if [[ `ls -dl ${name} | cut -c 1` = "-" ]]
	   then
		i=`expr $i + 1`
	   fi
	done

	for name in *
	do	
	   if [[ `ls -dl ${name} | cut -c 1` != "d" && `ls -dl ${name} | cut -c 1` != "-" ]] 
	   then
		echo "[$i]  ${name}"
		echo "------------------INFORMATION------------------"
			func_special $name
	   fi
	   if [[ `ls -dl ${name} | cut -c 1` != "d" && `ls -dl ${name} | cut -c 1` != "-" ]]
	   then
		i=`expr $i + 1`
	   fi
	done

}

project_first
project_second

