// Main program for verilator 6502 simulation; includes "driver" for Apple 1 I/O
// (simple fixed strings for the moment on input; should fix this to use a socket
// for console I/O)
//
// Copyright (c) 2010 Peter Monta

#include <iostream>
#include <fstream>
#include <string.h>
#include <stdlib.h>

#include "Vmain.h"
#include "verilated.h"

#include "Vmain_main.h"
#include "Vmain_ram_6502.h"

Vmain* top;

void read_binary_file(char* filename,int start_addr)
{ ifstream myfile;
  char c;
  int addr;

  myfile.open(filename, ios::in | ios::binary);
  if (!myfile) {
    cerr << "error opening code file" << endl;
    return; }
  addr = start_addr;
  cout << "starting address: " << hex << addr << endl << flush;
  while (1) {
    myfile.read(&c,1);
    if (!myfile)
      break;
    top->v->_ram_6502->mem[addr++] = (int)((unsigned char)c); }
  myfile.close();
  cout << "ending address: " << hex << addr << endl << flush;
}

void set_reset_vector(int x)
{ top->v->_ram_6502->mem[0xfffc] = x&0xff;
  top->v->_ram_6502->mem[0xfffd] = (x>>8)&0xff;
  cout << "reset vector: " << hex << x << endl << flush; }

unsigned int main_time = 0;

//char* x = "0FFF0.FFFF\r";
char* x = "0PRINT 1234/7\r";
int xi = 0;
//int xmax = 11;
int xmax = 14;

void handle_io(Vmain* top)
{ int display_flag,display_byte;
  int key_ready;

  display_flag = top->v->_ram_6502->display_flag;
  display_byte = top->v->_ram_6502->display_byte;
  if (display_flag) {
    if (display_byte==0x0d)
      display_byte = 0x0a;
    cout << char(display_byte) << flush;
    //    cout << "<" << int(display_byte) << ">" << flush;
    top->v->_ram_6502->display_flag = 0; }

  key_ready = top->v->_ram_6502->key_ready;
  if ((!key_ready) && (xi<xmax)) {
    //    cout << "[input "; cout << xi; cout << "]"; cout << flush;
    top->v->_ram_6502->mem[0xd010] = x[xi++] | 0x80;
    top->v->_ram_6502->key_ready = 1; }

}

int status_address = 0;
char code_filename[100];
int code_start;
int do_reset_vector = 0;
int reset_vector;

void args(int argc, char* argv[])
{ int i;
  for (i=0; i<argc; i++) {
    if (strcmp(argv[i],"-status_address")==0)
      status_address = 1;
    if (strcmp(argv[i],"-code")==0)
      strcpy(code_filename,argv[++i]);
    if (strcmp(argv[i],"-code_start")==0)
      code_start = atoi(argv[++i]);
    if (strcmp(argv[i],"-reset_vector")==0) {
      do_reset_vector = 1;
      reset_vector = atoi(argv[++i]); } } }

void status(Vmain* top)
{ if (status_address)
    cout << "[ab:" << hex << int(top->v->ab) << "]" << flush; }

int main(int argc, char **argv, char **env)
{ Verilated::commandArgs(argc, argv);
  args(argc, argv);

  top = new Vmain;

  read_binary_file(code_filename,code_start);
  if (do_reset_vector)
    set_reset_vector(reset_vector);

  top->v->eclk = 0;
  top->v->ereset = 1;
  top->eval();

  while (!Verilated::gotFinish()) {
    if (main_time>200)
      top->v->ereset = 0;
    top->v->eclk = 1;
    top->eval();
    main_time++;
    if (main_time>20000)
      handle_io(top);
    top->v->eclk = 0;
    top->eval();
    main_time++;
    if (main_time>20000)
      handle_io(top);
    if ((main_time%180000)==0)
      status(top);
    }

  exit(0); }
