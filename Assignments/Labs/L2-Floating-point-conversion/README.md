# Lab 2: Floating Point Converter

## Description

The purpose of this lab was to create a floating point converter. Our program received as input a 12-bit 2's complement value, and the task was to convert it to an 8-bit floating point counterpart. This was achieved using a top module with three submodules, in which one module converted the input to signed magnitude, another extracted a preliminary exponent field and a preliminary significand field, and the last module utilized proper f.p. rounding. 


## Included Files

### FPCVT.v
Top module that did the floating point conversion

### sign_mag_converter.v
This submodule took the 12-bit 2's complement input, and converted it to a 12-bit signed magnitude version. 

### preexp_and_presig.v
This submodule took as input the 12-bit signed magnitude value, and then counted the leading zeros. The leading zeros were used to determine what the proper exponent value should be, and was used when shifting for the presignificand. The presignificand consisted of five bits, in which the four most significant bytes are the significand, and the last is used for rounding purposes. 

### round_data.v
This submodule took as input the presignificand and the preexp, and calculated
the final exp and significand fields. The module rounded according to the least significand bit of the presignificand, and handled overflow appropriately

### fp_converter_TB_final.v
This was the testbench module used to test the execution of the program. It
is a relatively simple testbench, which tested normal cases, and the few edge
cases possible for this simple program