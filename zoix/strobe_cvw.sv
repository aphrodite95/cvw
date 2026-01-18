// ZOIX MODULE FOR FAULT INJECTION AND STROBING
`define TOPLEVEL wallypipelinedcore_gate

module strobe;

// Strobe primary outputs
initial begin 
    #22;
    forever begin 
        $fs_strobe(`TOPLEVEL);
        #10;
        $display("Strobed at %t", $time);
    end
end 

final begin 
    $display("DONE");
end 

endmodule
