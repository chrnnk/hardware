ServeRAID M1000 Series SAS/SATA Controller Firmware Update

Adapters Supported:  ServeRAID M1115 SAS/SATA Controller for IBM System X (81Y4448)
		     ServeRAID M1015 SAS/SATA Controller (46M0831)

(C) Copyright International Business Machines Corporation 1999, 2013. All 
rights reserved.  US Government Users Restricted Rights - Use, duplication, 
or disclosure restricted by GSA ADP Schedule Contract with IBM Corp.

Note: Before using this information and the product it supports, read the 
general information in "Notices and trademarks" in this document.


CONTENTS
________

1.0  Overview
2.0  Installation and setup instructions
     2.1 Standalone usage instructions
     2.2 Troubleshooting tips
3.0  Configuration information 
4.0  Unattended mode
5.0  Web site and support phone number
6.0  Notices and trademarks
7.0  Disclaimer


1.0  Overview
_____________

  1.1    This update includes a new firmware update for the ServeRAID M1000 
         Series SAS/SATA Controller.
  
  1.2    Limitations:
         - Rollback to previous firmware has only been verified for the
	   following levels: 20.10.1-0107 and 20.10.1-0101. All other levels
           have not been verified.
         - Roll back to 12.7.0.xxxx or earlier will cause the controller to
           stop functioning.
         - Power save technology is not supported on any physical or logical
           drives. 

  1.3    Problems fixed:
         - See change history

  1.4    Level of Recommendations and Prerequisites for the update:

  1.5    Dependencies:
         - None

  1.6    Update Contents
          o  ibm_fw_sraidmr_1000-20.11.1-0137_windows_32-64.exe
             - The executable update package
          o  ibm_fw_sraidmr_1000-20.11.1-0137_windows_32-64.chg
             - Change history


2.0  Installation and setup instructions
________________________________________

  This package can be used with several of IBM's update management tools, 
  including IBM UpdateXpress Manager, IBM UpdateXpress System Packs, IBM 
  ToolsCenter Bootable Media Creator, and IBM Director.

  It can also be used as a standalone package.  

  To use the package with one of IBM's update management tools, follow the 
  instructions that came with your specific management tool.

  2.1 Standalone usage instructions
  ---------------------------------

  Updating the local system:
    1) Run the executable by double clicking on the file icon, or by typing 
       'ibm_fw_sraidmr_1000-20.11.1-0137_windows_32-64.exe' at a command prompt.
    2) Select "Perform Update" and then click "Next". 
    3) Click "Update". 
    4) To perform another function, click "Back", otherwise click "Exit" to 
       exit the utility.
    5) Reboot system for firmware to take effect.


  2.2 Troubleshooting tips
  ------------------------
    None


3.0  Configuration information
______________________________
		
  For detailed setup instructions for your controller, refer to the 
  documentation on the "ServeRAID MR Support" CD.


4.0  Unattended Mode
____________________

  To run this package in unattended mode, use the following command:

    1) ibm_fw_sraidmr_1000-20.11.1-0137_windows_32-64.exe -s
    2) Reboot system for firmware to take effect.



5.0 Web Sites and Support Phone Number
______________________________________

  o  You can find support and downloads for IBM products from the IBM Support 
     Web site:

     http://www.ibm.com/support/
     
     You can find support and downloads specific to disk controllers by 
     searching for the "Disk Controller and RAID Software Matrix" from the 
     main support page.

  o  For the latest compatibility information, see the IBM ServerProven Web 
     site:

     http://www-03.ibm.com/servers/eserver/serverproven/compat/us/

  o  With the original purchase of an IBM hardware product, you have access 
     to extensive support coverage.  During the IBM hardware product warranty 
     period, you may call the IBM HelpCenter (1-800-IBM-SERV in the U.S.) 
     for hardware product assistance covered under the terms of the 
     IBM hardware warranty.


6.0 Trademarks and Notices
__________________________

  IBM and ServeRAID are trademarks or registered trademarks of International 
  Business Machines Corporation in the United States and other countries.

  LSI is a registered trademark of LSI Logic, Corp in the United States and 
  other countries.

  Windows is a trademark or registered trademark of Microsoft Corporation in 
  the United States and other countries.

  Other company, product, and service names may be trademarks or service marks 
  of others.


7.0 Disclaimer
______________

  THIS DOCUMENT IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND.
  IBM DISCLAIMS ALL WARRANTIES, WHETHER EXPRESS OR IMPLIED,
  INCLUDING WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF FITNESS
  FOR A PARTICULAR PURPOSE AND MERCHANTABILITY WITH RESPECT TO THE
  INFORMATION IN THIS DOCUMENT.  BY FURNISHING THIS DOCUMENT, IBM
  GRANTS NO LICENSES TO ANY PATENTS OR COPYRIGHTS.

  Note to U.S. Government Users -- Documentation related to
  restricted rights -- Use, duplication or disclosure is subject
  to restrictions set forth in GSA ADP Schedule Contract with
  IBM Corporation.
