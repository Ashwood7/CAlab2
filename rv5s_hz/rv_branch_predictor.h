# pragma once

#include "VSRTL/core/vsrtl_component.h"
#include "VSRTL/core/vsrtl_wire.h"
#include "rv_endpoint.h"

#include "../riscv.h"

namespace vsrtl {
namespace core {
using namespace Ripes;

class BranchPredictor : public Component {
public:
    BranchPredictor(std::string name, SimComponent* parent) : Component(name, parent) {
        update_wire->setSensitiveTo(branch_address);
        taken << [=] {
            return branchPredict();
        };

        branch_predict << [=] {
            if (branchPredict()) {
                return PcSrcBranch::BRANCH;
            } else {
                return PcSrcBranch::PC4;
            }
        };

        // --------------------------- Initialize the branch history table here if you need to ---------------------------


        update_wire->out << [=] {
            // --------------------------- Part 4. TODO: update branch history table here ---------------------------
            return 1;
        };
        update_wire->out >> endpoint->end_port;

    }

    INPUTPORT(is_branch, 1); // is_branch: whether the instruction is a branch/jump instruciton (JAL, JALR, BEQ, BNE, BGE, BLT, BLTU, BGEU).
    INPUTPORT(branch_address, RV_REG_WIDTH); // branch_address: the address of the branch instruction.

    // update_wire and endpoint are used to update the branch predictor at runtime.
    // Their return values are meaningless. You do not need to modify this.
    WIRE(update_wire, 1);
    SUBCOMPONENT(endpoint, Endpoint);

    OUTPUTPORT(taken, 1); // taken: the predicted result (0: not taken. 1: taken).
    OUTPUTPORT_ENUM(branch_predict, PcSrcBranch); // branch_predict: the selection of the source of pc in IF stage.

    void reset() {
        // --------------------------- Part 4. TODO: reset the branch history table here---------------------------
        // This function is called when click the 'reset' button in Ripes. You may need to do things such as clearing
        // the tables.
        // If you do not need to reset the table, you can leave this function empty.
        return;
    }

private:
    bool branchPredict() {
        // --------------------------- Part 4. TODO: implement branch predict policy ---------------------------
        if (is_branch.uValue() == 0){
            return 0;
        }
        return 1;
    }


    // --------------------------- Part 4. TODO: define your branch history table here ---------------------------
    // Hint: You may need to add some input ports to get the data used to update the branch history.


};

}  // namespace core
}  // namespace vsrtl
