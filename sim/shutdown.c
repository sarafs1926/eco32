/*
 * shutdown.c -- shutdown device
 */


#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "common.h"
#include "console.h"
#include "error.h"
#include "cpu.h"
#include "trace.h"
#include "mmu.h"
#include "icache.h"
#include "dcache.h"
#include "ram.h"
#include "rom.h"
#include "timer.h"
#include "dsp.h"
#include "kbd.h"
#include "serial.h"
#include "disk.h"
#include "sdcard.h"
#include "output.h"
#include "shutdown.h"
#include "graph.h"


Word shutdownRead(Word addr) {
  /* the shutdown device always returns 0 on read */
  return 0;
}


void shutdownWrite(Word addr, Word data) {
  /* the device supports a single function: exiting the simulator */
  cpuExit();
  traceExit();
  mmuExit();
  icacheExit();
  dcacheExit();
  ramExit();
  romExit();
  timerExit();
  displayExit();
  graphExit();
  keyboardExit();
  serialExit();
  diskExit();
  sdcardExit();
  outputExit();
  shutdownExit();
  cPrintf("ECO32 Simulator shutdown\n");
  cExit();
  exit(data & 0xFF);
}


void shutdownReset(void) {
  cPrintf("Resetting Shutdown Device...\n");
}


void shutdownInit(void) {
  shutdownReset();
}


void shutdownExit(void) {
}
