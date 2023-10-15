.PHONY: clean flash

BUILD 	= build
CST		= cst
SRC		= src
TOP		= top.v

all: output.fs

output1.json: $(BUILD)
	yosys -p "read_verilog $(SRC)/$(TOP); synth_gowin -top top -json $(BUILD)/$@"

output2.json: output1.json $(BUILD)
	nextpnr-gowin --json $(BUILD)/$< --freq 27 --write $(BUILD)/$@ --device GW1NR-LV9QN88PC6/I5 --family GW1N-9C --cst $(CST)/tangnano9k.cst

output.fs: output2.json $(BUILD)
	gowin_pack -d GW1N-9C -o $(BUILD)/$@ $(BUILD)/$<

$(BUILD):
	mkdir -p $(BUILD)

clean:
	rm -rf $(BUILD)

flash:
	openFPGALoader -b tangnano9k $(BUILD)/output.fs
