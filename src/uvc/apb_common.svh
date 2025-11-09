typedef enum{
  RD = 1'b0,
  WR = 1'b1
} op_type;

typedef enum {
  PASSIVE = 0,
  ACTIVE  = 1
} active_type;

typedef enum {
  MASTER    = 0,
  SLAVE     = 1,
  __NOTSET  = 2
} driver_type;

typedef enum {
  OKAY  = 0,
  ERROR = 1
} resp_type;
