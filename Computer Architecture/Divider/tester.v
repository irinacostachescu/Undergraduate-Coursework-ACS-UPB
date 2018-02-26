`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       UPB
// Engineer:      Dan Dragomir
//
// Create Date:   13:05:30 09/11/2017
// Design Name:   tester tema1
// Module Name:   tester
// Project Name:  tema1
// Target Device: ISim
// Tool versions: 14.6
// Description:   tester for homework 1: signed integer divider
////////////////////////////////////////////////////////////////////////////////

module tester;
parameter early_exit = 0;                   // boolean; bail on first error
parameter show_output = 0;                  // boolean; show what is being tested
parameter max_errors = 32;                  // integer; maximum number of errors to show

// Instantiate the Unit Under Test (UUT)
reg signed [7:0] tst_a, tst_b;
wire signed [8:0] tst_q;
wire signed [7:0] tst_r;
divider uut (
    .q(tst_q),
    .r(tst_r),
    .a(tst_a),
    .b(tst_b)
);

// Tester
integer i, j;                               // counters that enumerate all input operands
reg signed [7:0] a, b;                      // input operands
reg signed [8:0] q;                         // computed quotient
reg signed [7:0] r;                         // computed remainder

integer results_good;                       // number of outputs computed correctly
integer results_total;                      // total number of outputs
integer nonnegative_good;                   // number of outputs computed correctly from non-negative inputs
integer nonnegative_total;                  // total number of non-negative inputs
integer negative_good;                      // number of outputs computed correctly from negative inputs
integer negative_total;                     // total number of negative inputs

real percentage;                            // test passed percentage
real grade;                                 // test grade
integer file;                               // results file

initial begin
    results_good = 0;
    results_total = 0;
    nonnegative_good = 0;
    nonnegative_total = 0;
    negative_good = 0;
    negative_total = 0;
    for(i = -128; i <= 127; i = i + 1) begin
        for(j = -128; j <= 127; j = j + 1) begin
            if(j == 0)                      // skip divide by 0
                j = j + 1;

            results_total = results_total + 1;
            if(i >= 0 && j >= 0)
                nonnegative_total = nonnegative_total + 1;
            else
                negative_total = negative_total + 1;

            a = i;                          // force correct width for printing
            b = j;                          // force correct width for printing
            q = i / j;                      // force correct width for printing
            r = i % j;                      // force correct width for printing

            if(show_output)
                $write("dividing: a = %d, b = %d", a, b);

            tst_a = a;
            tst_b = b;
            #1;                             // needed to force update of output signals

            if(q === tst_q && r === tst_r) begin    // result is good
                results_good = results_good + 1;
                if(i >= 0 && j >= 0)
                    nonnegative_good = nonnegative_good + 1;
                else
                    negative_good = negative_good + 1;

                if(show_output)
                    $write(", q = %d, r = %d\tok\n", tst_q, tst_r);
            end
            else begin                      // result is wrong
                if(show_output)
                    $write("\n");

                if(show_output || (results_total - results_good <= max_errors))
                    $write("\terror: a = %d, b = %d, q = %d, r = %d, expected q = %d, r = %d\n", tst_a, tst_b, tst_q, tst_r, q, r);
                if(!show_output && (results_total - results_good == max_errors)) begin
                    $write("\t.\n");
                    $write("\t.\n");
                    $write("\t.\n");
                end

                if(early_exit) begin        // force exit from testing loop
                    i = 127;
                    j = 127;
                end
            end
        end
     end

    if(results_good == results_total)
        $write("test ok\n");

    percentage = results_good * 1.0 / results_total;
    grade = nonnegative_good * 0.5 / nonnegative_total + negative_good * 0.5 / negative_total;

    // print results
    file = $fopen("result.tester");
    $fwrite(file, "%6.2f: %0d correct nonnegative results and %0d correct negative results out of %0d (%6.2f%% completed)\n", 10.0 * (grade - 1.0), nonnegative_good, negative_good, results_total, 100.0 * percentage);
    $fclose(file);
end

endmodule
