#include <iostream>
#include <fstream>

#include "Vmain.h"
#include "verilated.h"

Vmain* top;

void read_binary_file(char* filename,int start_addr)
{ ifstream myfile;
  char c;
  int addr;

  myfile.open(filename, ios::in | ios::binary);
  addr = start_addr;
  while (1) {
    myfile.read(&c,1);
    if (!myfile)
      break;
    top->v__DOT___ram_6502__DOT__mem[addr++] = (unsigned char)c; }
  myfile.close();
  cout << "ending address: " << hex << addr << endl << flush;
  top->v__DOT___ram_6502__DOT__mem[0xfffc] = 0x00;
  top->v__DOT___ram_6502__DOT__mem[0xfffd] = 0xe0;
}

unsigned int main_time = 0;

//char* x = "0FFF0.FFFF\r";
char* x = "0PRINT 1234/7\rPRINT 1234/7\r";
int xi = 0;
//int xmax = 11;
int xmax = 26;

void handle_io(Vmain* top)
{ int display_flag,display_byte;
  int key_ready;

  display_flag = top->v__DOT___ram_6502__DOT__display_flag;
  display_byte = top->v__DOT___ram_6502__DOT__display_byte;
  if (display_flag) {
    if (display_byte==0x0d)
      display_byte = 0x0a;
    cout << char(display_byte) << flush;
    //    cout << "<" << int(display_byte) << ">" << flush;
    top->v__DOT___ram_6502__DOT__display_flag = 0; }

  key_ready = top->v__DOT___ram_6502__DOT__key_ready;
  if ((!key_ready) && (xi<xmax)) {
    //    cout << "[input "; cout << xi; cout << "]"; cout << flush;
    top->v__DOT___ram_6502__DOT__mem[0xd010] = x[xi++] | 0x80;
    top->v__DOT___ram_6502__DOT__key_ready = 1; }

}

void status(Vmain* top)
{}
//{ cout << "[ab:" << hex << int(top->v__DOT__ab) << "]" << flush; }

int main(int argc, char **argv, char **env)
{ Verilated::commandArgs(argc, argv);
  top = new Vmain;
  top->v__DOT__eclk = 0;
  top->v__DOT__ereset = 1;
  read_binary_file("../6502-test-code/test1.bin",0xfff0);
//  read_binary_file("../6502-test-code/apple1monitor.bin",0xff00);
//  read_binary_file("../6502-test-code/apple1basic.bin",0xe000);
  top->eval();
  while (!Verilated::gotFinish()) {
    if (main_time>100)
      top->v__DOT__ereset = 0;
    top->v__DOT__eclk = 1;
    top->eval();
    main_time++;
    if (main_time>40000)
      handle_io(top);
    top->v__DOT__eclk = 0;
    top->eval();
    main_time++;
    if (main_time>40000)
      handle_io(top);
    if ((main_time%10000)==0) status(top);
    }
  exit(0); }
