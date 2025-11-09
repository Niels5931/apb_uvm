typedef enum{
  RD = 1'b0,
  WR = 1'b1
} op_type;

typedef enum {
  UVM_PASSIVE = 0,
  UVM_ACTIVE  = 1,
  __NOTSET   = 2
} active_type;

typedef enum {
  OKAY  = 0,
  ERROR = 1
} resp_type;
