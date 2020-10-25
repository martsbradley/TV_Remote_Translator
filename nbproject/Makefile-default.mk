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
MKDIR=mkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=cof
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/FinalProject_16F628A.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/FinalProject_16F628A.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/AssemblyRoutines.p1 ${OBJECTDIR}/main.p1 ${OBJECTDIR}/usart.p1
POSSIBLE_DEPFILES=${OBJECTDIR}/AssemblyRoutines.p1.d ${OBJECTDIR}/main.p1.d ${OBJECTDIR}/usart.p1.d

# Object Files
OBJECTFILES=${OBJECTDIR}/AssemblyRoutines.p1 ${OBJECTDIR}/main.p1 ${OBJECTDIR}/usart.p1


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
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/FinalProject_16F628A.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=16F628A
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/AssemblyRoutines.p1: AssemblyRoutines.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	${MP_CC} --pass1 AssemblyRoutines.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -DXTAL_FREQ=4MHZ -N31 -I"/usr/hitech/picc/9.80a/include" --warn=0 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,-speed,+space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@${MP_CC} --scandep  AssemblyRoutines.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -DXTAL_FREQ=4MHZ -N31 -I"/usr/hitech/picc/9.80a/include" --warn=0 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --opt=default,+asm,-asmfile,-speed,+space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@echo ${OBJECTDIR}/AssemblyRoutines.p1: > ${OBJECTDIR}/AssemblyRoutines.p1.d
	@cat ${OBJECTDIR}/AssemblyRoutines.dep >> ${OBJECTDIR}/AssemblyRoutines.p1.d
	@${FIXDEPS} "${OBJECTDIR}/AssemblyRoutines.p1.d" $(SILENT) -ht  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/main.p1: main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	${MP_CC} --pass1 main.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -DXTAL_FREQ=4MHZ -N31 -I"/usr/hitech/picc/9.80a/include" --warn=0 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,-speed,+space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@${MP_CC} --scandep  main.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -DXTAL_FREQ=4MHZ -N31 -I"/usr/hitech/picc/9.80a/include" --warn=0 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --opt=default,+asm,-asmfile,-speed,+space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@echo ${OBJECTDIR}/main.p1: > ${OBJECTDIR}/main.p1.d
	@cat ${OBJECTDIR}/main.dep >> ${OBJECTDIR}/main.p1.d
	@${FIXDEPS} "${OBJECTDIR}/main.p1.d" $(SILENT) -ht  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/usart.p1: usart.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	${MP_CC} --pass1 usart.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -DXTAL_FREQ=4MHZ -N31 -I"/usr/hitech/picc/9.80a/include" --warn=0 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,-speed,+space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@${MP_CC} --scandep  usart.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -DXTAL_FREQ=4MHZ -N31 -I"/usr/hitech/picc/9.80a/include" --warn=0 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --opt=default,+asm,-asmfile,-speed,+space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@echo ${OBJECTDIR}/usart.p1: > ${OBJECTDIR}/usart.p1.d
	@cat ${OBJECTDIR}/usart.dep >> ${OBJECTDIR}/usart.p1.d
	@${FIXDEPS} "${OBJECTDIR}/usart.p1.d" $(SILENT) -ht  -rsi ${MP_CC_DIR}../ 
	
else
${OBJECTDIR}/AssemblyRoutines.p1: AssemblyRoutines.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	${MP_CC} --pass1 AssemblyRoutines.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -DXTAL_FREQ=4MHZ -N31 -I"/usr/hitech/picc/9.80a/include" --warn=0 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,-speed,+space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@${MP_CC} --scandep  AssemblyRoutines.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -DXTAL_FREQ=4MHZ -N31 -I"/usr/hitech/picc/9.80a/include" --warn=0 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --opt=default,+asm,-asmfile,-speed,+space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@echo ${OBJECTDIR}/AssemblyRoutines.p1: > ${OBJECTDIR}/AssemblyRoutines.p1.d
	@cat ${OBJECTDIR}/AssemblyRoutines.dep >> ${OBJECTDIR}/AssemblyRoutines.p1.d
	@${FIXDEPS} "${OBJECTDIR}/AssemblyRoutines.p1.d" $(SILENT) -ht  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/main.p1: main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	${MP_CC} --pass1 main.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -DXTAL_FREQ=4MHZ -N31 -I"/usr/hitech/picc/9.80a/include" --warn=0 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,-speed,+space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@${MP_CC} --scandep  main.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -DXTAL_FREQ=4MHZ -N31 -I"/usr/hitech/picc/9.80a/include" --warn=0 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --opt=default,+asm,-asmfile,-speed,+space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@echo ${OBJECTDIR}/main.p1: > ${OBJECTDIR}/main.p1.d
	@cat ${OBJECTDIR}/main.dep >> ${OBJECTDIR}/main.p1.d
	@${FIXDEPS} "${OBJECTDIR}/main.p1.d" $(SILENT) -ht  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/usart.p1: usart.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	${MP_CC} --pass1 usart.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -DXTAL_FREQ=4MHZ -N31 -I"/usr/hitech/picc/9.80a/include" --warn=0 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,-speed,+space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@${MP_CC} --scandep  usart.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -DXTAL_FREQ=4MHZ -N31 -I"/usr/hitech/picc/9.80a/include" --warn=0 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --opt=default,+asm,-asmfile,-speed,+space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@echo ${OBJECTDIR}/usart.p1: > ${OBJECTDIR}/usart.p1.d
	@cat ${OBJECTDIR}/usart.dep >> ${OBJECTDIR}/usart.p1.d
	@${FIXDEPS} "${OBJECTDIR}/usart.p1.d" $(SILENT) -ht  -rsi ${MP_CC_DIR}../ 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/FinalProject_16F628A.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE) -odist/${CND_CONF}/${IMAGE_TYPE}/FinalProject_16F628A.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  -mdist/${CND_CONF}/${IMAGE_TYPE}/FinalProject_16F628A.${IMAGE_TYPE}.map --summary=default,-psect,-class,+mem,-hex --chip=$(MP_PROCESSOR_OPTION) -P --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,-speed,+space,-debug,-9 -D__DEBUG --debugger=pickit3 -DXTAL_FREQ=4MHZ -N31 -I"/usr/hitech/picc/9.80a/include" --warn=0  --double=24 --float=24 --addrqual=ignore --mode=lite --output=default,-inhx032 -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s" ${OBJECTFILES_QUOTED_IF_SPACED}  
	@${RM} dist/${CND_CONF}/${IMAGE_TYPE}/FinalProject_16F628A.${IMAGE_TYPE}.hex
else
dist/${CND_CONF}/${IMAGE_TYPE}/FinalProject_16F628A.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE) -odist/${CND_CONF}/${IMAGE_TYPE}/FinalProject_16F628A.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  -mdist/${CND_CONF}/${IMAGE_TYPE}/FinalProject_16F628A.${IMAGE_TYPE}.map --summary=default,-psect,-class,+mem,-hex --chip=$(MP_PROCESSOR_OPTION) -P --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,-speed,+space,-debug,-9 -DXTAL_FREQ=4MHZ -N31 -I"/usr/hitech/picc/9.80a/include" --warn=0  --double=24 --float=24 --addrqual=ignore --mode=lite --output=default,-inhx032 -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s" ${OBJECTFILES_QUOTED_IF_SPACED}  
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

DEPFILES=$(shell "${PATH_TO_IDE_BIN}"mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif