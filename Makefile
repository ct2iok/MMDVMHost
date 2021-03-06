# This makefile is for all platforms, but doesn't include support for the HD44780 display on the Raspberry Pi.

CC      = gcc
CXX     = g++
CFLAGS  = -g -O3 -Wall -std=c++0x -pthread
LIBS    = -lpthread
LDFLAGS = -g

OBJECTS = \
		AMBEFEC.o BCH.o BPTC19696.o Conf.o CRC.o DelayBuffer.o Display.o DMRControl.o DMRCSBK.o DMRData.o DMRDataHeader.o DMREMB.o DMREmbeddedData.o DMRFullLC.o \
		DMRLookup.o DMRLC.o DMRNetwork.o DMRShortLC.o DMRSlot.o DMRSlotType.o DMRAccessControl.o DMRTrellis.o DStarControl.o DStarHeader.o DStarNetwork.o \
		DStarSlowData.o Golay2087.o Golay24128.o Hamming.o JitterBuffer.o LCDproc.o Log.o MMDVMHost.o Modem.o ModemSerialPort.o Mutex.o NetworkInfo.o Nextion.o \
		NullDisplay.o P25Audio.o P25Control.o P25Data.o P25LowSpeedData.o P25Network.o P25NID.o P25Trellis.o P25Utils.o QR1676.o RS129.o RS241213.o \
		RSSIInterpolator.o SerialController.o SerialPort.o SHA256.o StopWatch.o Sync.o TFTSerial.o Thread.o Timer.o UDPSocket.o UMP.o Utils.o YSFControl.o \
		YSFConvolution.o YSFFICH.o YSFNetwork.o YSFPayload.o

all:		MMDVMHost

MMDVMHost:	GitVersion.h $(OBJECTS) 
		$(CXX) $(OBJECTS) $(CFLAGS) $(LIBS) -o MMDVMHost

%.o: %.cpp
		$(CXX) $(CFLAGS) -c -o $@ $<

clean:
		$(RM) MMDVMHost *.o *.d *.bak *~ GitVersion.h

# Export the current git version if the index file exists, else 000...
GitVersion.h:
ifneq ("$(wildcard .git/index)","")
	echo "const char *gitversion = \"$(shell git rev-parse HEAD)\";" > $@
else
	echo "const char *gitversion = \"0000000000000000000000000000000000000000\";" > $@
endif
