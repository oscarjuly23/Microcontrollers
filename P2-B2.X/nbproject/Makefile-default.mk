#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/P2-B2.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/P2-B2.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=-mafrlcsj
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS

else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=main.c TCentral.c TTeclat.c LcTLCD.c TITTIMER.c TSms.c TMenu.c TSIO.c TUsers.c THora.c TADC.c TAltaveu.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/main.p1 ${OBJECTDIR}/TCentral.p1 ${OBJECTDIR}/TTeclat.p1 ${OBJECTDIR}/LcTLCD.p1 ${OBJECTDIR}/TITTIMER.p1 ${OBJECTDIR}/TSms.p1 ${OBJECTDIR}/TMenu.p1 ${OBJECTDIR}/TSIO.p1 ${OBJECTDIR}/TUsers.p1 ${OBJECTDIR}/THora.p1 ${OBJECTDIR}/TADC.p1 ${OBJECTDIR}/TAltaveu.p1
POSSIBLE_DEPFILES=${OBJECTDIR}/main.p1.d ${OBJECTDIR}/TCentral.p1.d ${OBJECTDIR}/TTeclat.p1.d ${OBJECTDIR}/LcTLCD.p1.d ${OBJECTDIR}/TITTIMER.p1.d ${OBJECTDIR}/TSms.p1.d ${OBJECTDIR}/TMenu.p1.d ${OBJECTDIR}/TSIO.p1.d ${OBJECTDIR}/TUsers.p1.d ${OBJECTDIR}/THora.p1.d ${OBJECTDIR}/TADC.p1.d ${OBJECTDIR}/TAltaveu.p1.d

# Object Files
OBJECTFILES=${OBJECTDIR}/main.p1 ${OBJECTDIR}/TCentral.p1 ${OBJECTDIR}/TTeclat.p1 ${OBJECTDIR}/LcTLCD.p1 ${OBJECTDIR}/TITTIMER.p1 ${OBJECTDIR}/TSms.p1 ${OBJECTDIR}/TMenu.p1 ${OBJECTDIR}/TSIO.p1 ${OBJECTDIR}/TUsers.p1 ${OBJECTDIR}/THora.p1 ${OBJECTDIR}/TADC.p1 ${OBJECTDIR}/TAltaveu.p1

# Source Files
SOURCEFILES=main.c TCentral.c TTeclat.c LcTLCD.c TITTIMER.c TSms.c TMenu.c TSIO.c TUsers.c THora.c TADC.c TAltaveu.c


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/P2-B2.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=18F4321
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/main.p1: main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/main.p1.d 
	@${RM} ${OBJECTDIR}/main.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/main.p1 main.c 
	@-${MV} ${OBJECTDIR}/main.d ${OBJECTDIR}/main.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/main.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/TCentral.p1: TCentral.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/TCentral.p1.d 
	@${RM} ${OBJECTDIR}/TCentral.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/TCentral.p1 TCentral.c 
	@-${MV} ${OBJECTDIR}/TCentral.d ${OBJECTDIR}/TCentral.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/TCentral.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/TTeclat.p1: TTeclat.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/TTeclat.p1.d 
	@${RM} ${OBJECTDIR}/TTeclat.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/TTeclat.p1 TTeclat.c 
	@-${MV} ${OBJECTDIR}/TTeclat.d ${OBJECTDIR}/TTeclat.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/TTeclat.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/LcTLCD.p1: LcTLCD.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/LcTLCD.p1.d 
	@${RM} ${OBJECTDIR}/LcTLCD.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/LcTLCD.p1 LcTLCD.c 
	@-${MV} ${OBJECTDIR}/LcTLCD.d ${OBJECTDIR}/LcTLCD.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/LcTLCD.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/TITTIMER.p1: TITTIMER.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/TITTIMER.p1.d 
	@${RM} ${OBJECTDIR}/TITTIMER.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/TITTIMER.p1 TITTIMER.c 
	@-${MV} ${OBJECTDIR}/TITTIMER.d ${OBJECTDIR}/TITTIMER.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/TITTIMER.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/TSms.p1: TSms.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/TSms.p1.d 
	@${RM} ${OBJECTDIR}/TSms.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/TSms.p1 TSms.c 
	@-${MV} ${OBJECTDIR}/TSms.d ${OBJECTDIR}/TSms.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/TSms.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/TMenu.p1: TMenu.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/TMenu.p1.d 
	@${RM} ${OBJECTDIR}/TMenu.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/TMenu.p1 TMenu.c 
	@-${MV} ${OBJECTDIR}/TMenu.d ${OBJECTDIR}/TMenu.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/TMenu.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/TSIO.p1: TSIO.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/TSIO.p1.d 
	@${RM} ${OBJECTDIR}/TSIO.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/TSIO.p1 TSIO.c 
	@-${MV} ${OBJECTDIR}/TSIO.d ${OBJECTDIR}/TSIO.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/TSIO.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/TUsers.p1: TUsers.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/TUsers.p1.d 
	@${RM} ${OBJECTDIR}/TUsers.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/TUsers.p1 TUsers.c 
	@-${MV} ${OBJECTDIR}/TUsers.d ${OBJECTDIR}/TUsers.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/TUsers.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/THora.p1: THora.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/THora.p1.d 
	@${RM} ${OBJECTDIR}/THora.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/THora.p1 THora.c 
	@-${MV} ${OBJECTDIR}/THora.d ${OBJECTDIR}/THora.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/THora.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/TADC.p1: TADC.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/TADC.p1.d 
	@${RM} ${OBJECTDIR}/TADC.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/TADC.p1 TADC.c 
	@-${MV} ${OBJECTDIR}/TADC.d ${OBJECTDIR}/TADC.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/TADC.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/TAltaveu.p1: TAltaveu.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/TAltaveu.p1.d 
	@${RM} ${OBJECTDIR}/TAltaveu.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/TAltaveu.p1 TAltaveu.c 
	@-${MV} ${OBJECTDIR}/TAltaveu.d ${OBJECTDIR}/TAltaveu.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/TAltaveu.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
else
${OBJECTDIR}/main.p1: main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/main.p1.d 
	@${RM} ${OBJECTDIR}/main.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/main.p1 main.c 
	@-${MV} ${OBJECTDIR}/main.d ${OBJECTDIR}/main.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/main.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/TCentral.p1: TCentral.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/TCentral.p1.d 
	@${RM} ${OBJECTDIR}/TCentral.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/TCentral.p1 TCentral.c 
	@-${MV} ${OBJECTDIR}/TCentral.d ${OBJECTDIR}/TCentral.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/TCentral.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/TTeclat.p1: TTeclat.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/TTeclat.p1.d 
	@${RM} ${OBJECTDIR}/TTeclat.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/TTeclat.p1 TTeclat.c 
	@-${MV} ${OBJECTDIR}/TTeclat.d ${OBJECTDIR}/TTeclat.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/TTeclat.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/LcTLCD.p1: LcTLCD.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/LcTLCD.p1.d 
	@${RM} ${OBJECTDIR}/LcTLCD.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/LcTLCD.p1 LcTLCD.c 
	@-${MV} ${OBJECTDIR}/LcTLCD.d ${OBJECTDIR}/LcTLCD.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/LcTLCD.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/TITTIMER.p1: TITTIMER.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/TITTIMER.p1.d 
	@${RM} ${OBJECTDIR}/TITTIMER.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/TITTIMER.p1 TITTIMER.c 
	@-${MV} ${OBJECTDIR}/TITTIMER.d ${OBJECTDIR}/TITTIMER.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/TITTIMER.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/TSms.p1: TSms.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/TSms.p1.d 
	@${RM} ${OBJECTDIR}/TSms.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/TSms.p1 TSms.c 
	@-${MV} ${OBJECTDIR}/TSms.d ${OBJECTDIR}/TSms.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/TSms.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/TMenu.p1: TMenu.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/TMenu.p1.d 
	@${RM} ${OBJECTDIR}/TMenu.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/TMenu.p1 TMenu.c 
	@-${MV} ${OBJECTDIR}/TMenu.d ${OBJECTDIR}/TMenu.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/TMenu.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/TSIO.p1: TSIO.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/TSIO.p1.d 
	@${RM} ${OBJECTDIR}/TSIO.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/TSIO.p1 TSIO.c 
	@-${MV} ${OBJECTDIR}/TSIO.d ${OBJECTDIR}/TSIO.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/TSIO.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/TUsers.p1: TUsers.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/TUsers.p1.d 
	@${RM} ${OBJECTDIR}/TUsers.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/TUsers.p1 TUsers.c 
	@-${MV} ${OBJECTDIR}/TUsers.d ${OBJECTDIR}/TUsers.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/TUsers.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/THora.p1: THora.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/THora.p1.d 
	@${RM} ${OBJECTDIR}/THora.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/THora.p1 THora.c 
	@-${MV} ${OBJECTDIR}/THora.d ${OBJECTDIR}/THora.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/THora.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/TADC.p1: TADC.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/TADC.p1.d 
	@${RM} ${OBJECTDIR}/TADC.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/TADC.p1 TADC.c 
	@-${MV} ${OBJECTDIR}/TADC.d ${OBJECTDIR}/TADC.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/TADC.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/TAltaveu.p1: TAltaveu.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/TAltaveu.p1.d 
	@${RM} ${OBJECTDIR}/TAltaveu.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/TAltaveu.p1 TAltaveu.c 
	@-${MV} ${OBJECTDIR}/TAltaveu.d ${OBJECTDIR}/TAltaveu.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/TAltaveu.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/P2-B2.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -Wl,-Map=dist/${CND_CONF}/${IMAGE_TYPE}/P2-B2.X.${IMAGE_TYPE}.map  -D__DEBUG=1  -DXPRJ_default=$(CND_CONF)  -Wl,--defsym=__MPLAB_BUILD=1  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     -mrom=default,-1dc0-1fff -mram=default,-1f4-1ff,-f9c-f9c,-fd4-fd4,-fdb-fdf,-fe3-fe7,-feb-fef,-ffd-fff  $(COMPARISON_BUILD) -Wl,--memorysummary,dist/${CND_CONF}/${IMAGE_TYPE}/memoryfile.xml -o dist/${CND_CONF}/${IMAGE_TYPE}/P2-B2.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
	@${RM} dist/${CND_CONF}/${IMAGE_TYPE}/P2-B2.X.${IMAGE_TYPE}.hex 
	
else
dist/${CND_CONF}/${IMAGE_TYPE}/P2-B2.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -Wl,-Map=dist/${CND_CONF}/${IMAGE_TYPE}/P2-B2.X.${IMAGE_TYPE}.map  -DXPRJ_default=$(CND_CONF)  -Wl,--defsym=__MPLAB_BUILD=1  -fno-short-double -fno-short-float -memi=wordwrite -Os -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -msummary=-psect,-class,+mem,-hex,-file  -ginhx032 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto     $(COMPARISON_BUILD) -Wl,--memorysummary,dist/${CND_CONF}/${IMAGE_TYPE}/memoryfile.xml -o dist/${CND_CONF}/${IMAGE_TYPE}/P2-B2.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
	
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
