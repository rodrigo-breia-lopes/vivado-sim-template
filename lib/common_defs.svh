`define ASSERT(cond, msg, time) \
    if (!(cond)) $error("%s at %0t", msg, time);
