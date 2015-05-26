Cell Image Super Resolution Recovery Introduction

In the folder ELM_SR
Use the ELM algorithm to complete the cell image super resolution recovery
How to use
Run the script ELM.m, then choose the first picture in HF-32 folder, finally choose the first picture in AC8-int folder. This is used to train the model. Finally it can turn the low resolution image in ac_8 pictures to ac_32 high resolution pictures. 

 In the folder SRCNN
It uses the CNN algorithm to complete the image recovery
The model has been already trained (which is providded by the mat file), I use a low resolution image for test.
 More information can be get from the Reademe.txt

In the folder ELM_CNN_COMPARE
Make a comparision between the CNN and ELM (ELM_VS_CNN.m). Also choose the first picture in HF-32 firstly, then choose the first picture in AC8-int to train the ELM model. 
