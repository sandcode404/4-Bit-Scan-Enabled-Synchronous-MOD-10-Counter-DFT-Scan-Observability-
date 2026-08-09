This project demonstrates scan observability at the RTL level using a 4-bit scan-enabled MOD-10 synchronous counter. The four functional flip-flops are converted into scan cells and connected as a serial scan chain from SCAN_IN to SCAN_OUT, while retaining the original MOD-10 counter logic. A test vector of 0111 is used as the controlled internal state that could be applied to test a fault at a target internal site. Although no fault is injected in this implementation, the scan design flow required to make the resulting internal response observable is demonstrated.

Demonstrated scan observability flow:
Test Vector: 0111
       
1. SHIFT-IN
   scan_en = 1
   0111 loaded into 4 scan cells
   → 4 clock cycles
       
2. CAPTURE
   scan_en = 0
   One functional clock applied
   0111 → 1000
   → response captured in scan cells
       
3. SHIFT-OUT
   scan_en = 1
   Captured 1000 shifted to SCAN_OUT
   → 4 clock cycles
       
Observable response: 1000

The demonstration therefore focuses on the observability aspect of DFT scan design: a known test vector is first loaded into otherwise internal sequential elements, the functional logic produces a response during capture, and that internal response is subsequently shifted out through the serial scan chain. If a fault were present at a target internal site and affected the captured response, the resulting shift-out pattern would differ from the expected response, allowing the fault effect to be observed at SCAN_OUT.
