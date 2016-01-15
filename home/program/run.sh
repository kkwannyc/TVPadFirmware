#!/bin/sh                                                                       
 
if ["`df -h | grep storage`" = ""]; then
	 echo "/storage is need init."
     umount /dev/ndda4
     mkfs.ext2 /dev/ndda4
     mount /dev/ndda4 /storage
fi    
mount -o remount, rw /program
mount -o remount, rw /storage
mount -o remount, rw /home



rm -rf /storage/images
mkdir /storage/images


vsresult=0
if [ -f /etc/init.d/config ];then      
	vsresult=`grep -c "cvbs" /etc/init.d/config`
fi

RESETCOUNTER=30                                                                 
while [ $RESETCOUNTER -gt 0 ]                                                   
do 
	if [ $vsresult = "0" ]; then
		rm -f core >/dev/null 2>&1                                              
		./clearprocess
				                                                                
		if [ -f desktop/desktop ];then      
			./network &     						
			./login  &
			./bidaemon &
			#./remoteserver &
			sleep 1			                                                    
			./desktop/desktop -nomouse -qws                                       
		else                                                                    
		   break;                      
		fi		 
	else
		if [ -f /home/config/config.ini ];then      
			rm -f core >/dev/null 2>&1                                              
			./clearProcess
				                                                                
			if [ -f desktop/desktop ];then      
				./network &     						
				./login  & 
				./bidaemon & 
				#./remoteserver &  
				sleep 1			                                                    
				./desktop/desktop -nomouse -qws                                       
			else                                                                    
			   break;                                                          
			fi                           
		else                                                                    
			./startguider -nomouse -qws   
			sync                                         
		fi                                                                                
	fi   

	sleep 2                                                                                              
	RESETCOUNTER=$((RESETCOUNTER - 1))                                      
	echo 'RESETCOUNTER' $RESETCOUNTER   
                       
done                                                                                                                                                       

echo "1" > /storage/check.box                                                                           
sync                                                                            
reboot
