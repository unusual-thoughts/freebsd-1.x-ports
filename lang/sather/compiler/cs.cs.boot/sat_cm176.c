/* sat_cm176.c : Sather class: SAT_CMDFILE, dbg=F, gc=T, chk=F */

#include "all_.h"
#include "c_names_.h"

static char __sather_compiled__;
extern void error_msg(ptr s__);
extern ptr str_ptr_(ptr s__);
extern int scanf_val_();
extern ptr stdin_();
extern ptr stdout_();
extern ptr stderr_();
extern char check_eof_(ptr fp__);
extern int get_ci_(ptr fp__);
extern int fscanfi_(ptr fp__);
extern double fscanfd_(ptr fp__);
extern void error_exit(ptr s__);
extern void ungetc(char ch__, ptr fp__);
extern void fputc(char ch__, ptr fp__);
extern void fprintfi_(ptr fp__, int in__);
extern void fprintfs_(ptr fp__, ptr st__);
extern void fprintfd_(ptr fp__, double do__);
extern ptr fopenr_(ptr s__);
extern ptr fopenw_(ptr s__);
extern ptr fopena_(ptr s__);
extern void fclose(ptr fp__);
extern void fflush(ptr fp__);
extern ptr popenr_(ptr c__);
extern ptr popenw_(ptr c__);
extern void pclose(ptr fp__);
extern void fseek(ptr fp__, int off__, int where__);

extern ptr STR70_create_(ptr self__, int init_str_len__);
extern void STR70_init_(ptr self__);
extern ptr STR70_push_(ptr self__, char e__);
extern ptr STR70_terminate_(ptr self__);
extern char STR70_is_equal_(ptr self__, ptr strv__);
extern ptr STR70_strval_(ptr self__);
extern char INT15_to_c_(int self__);
extern ptr STR20_create_(ptr self__);
extern ptr STR20_s_(ptr self__, ptr st__);
extern ptr STR20_c_(ptr self__, char ch__);
extern ptr STR20_i_(ptr self__, int in__);
extern struct { int tp_; int sz_; char st_; } gs1060_;
extern struct { int tp_; int sz_; char st_; } gs1062_;
extern struct { int tp_; int sz_; char st_; } gs1064_;
extern struct { int tp_; int sz_; char st_; } gs1066_;
extern struct { int tp_; int sz_; char st_; } gs1068_;
extern struct { int tp_; int sz_; char st_; } gs1070_;
extern struct { int tp_; int sz_; char st_; } gs1072_;
extern struct { int tp_; int sz_; char st_; } gs1074_;
#include "macros_.h"



/*constant*/ ptr SAT176_object_files_kw_ = (ptr)(&gs1062_);
/*constant*/ ptr SAT176_cc_flags_kw_ = (ptr)(&gs1064_);
/*constant*/ ptr SAT176_c_macro_kw_ = (ptr)(&gs1066_);
/*constant*/ ptr SAT176_c_name_kw_ = (ptr)(&gs1068_);
/*constant*/ ptr SAT176_include_kw_ = (ptr)(&gs1070_);
/*constant*/ ptr SAT176_sather_home_kw_ = (ptr)(&gs1072_);
/*constant*/ ptr SAT176_c_compiler_kw_ = (ptr)(&gs1074_);
/*constant*/ int SAT176_source_files_ind_ = 0;
/*constant*/ int SAT176_object_files_ind_ = 1;
/*constant*/ int SAT176_cc_flags_ind_ = 2;
/*constant*/ int SAT176_c_macro_ind_ = 3;
/*constant*/ int SAT176_c_name_ind_ = 4;
/*constant*/ int SAT176_include_ind_ = 5;
/*constant*/ int SAT176_sather_home_ind_ = 6;
/*constant*/ int SAT176_c_compiler_ind_ = 7;
/*constant*/ int SAT176_compile_keys_fst_ind_ = 0;
/*constant*/ int SAT176_compile_keys_lst_ind_ = 7;
/*constant*/ int SAT176_num_compile_keys_ = 8;
/*constant*/ int SAT176_non_compile_key_ind_ = 8;
/*constant*/ int SAT176_eof_tok_ = -1;
/*constant*/ int SAT176_ident_tok_ = -2;
/*constant*/ int SAT176_qexp_tok_ = -3;
char SAT176_compile_key_p_(ptr self__, int i__);
ptr SAT176_initialize_(ptr self__, ptr initarg__);
/*constant*/ int SAT176_eof_ = -1;
/*shared*/ int SAT176_error_val_;
/*constant*/ int SAT176_read_error_ = 1;
/*constant*/ int SAT176_eof_error_ = 2;
/*constant*/ int SAT176_open_error_ = 3;
int SAT176_error_(ptr self__);
ptr SAT176_create_(ptr self__, ptr nm__);
ptr SAT176_in_(ptr self__);
ptr SAT176_out_(ptr self__);
ptr SAT176_err_(ptr self__);
char SAT176_check_eof_(ptr self__);
char SAT176_get_c_(ptr self__);
int SAT176_get_ci_(ptr self__);
char SAT176_get_b_(ptr self__);
int SAT176_get_i_(ptr self__);
float SAT176_get_r_(ptr self__);
double SAT176_get_d_(ptr self__);
ptr SAT176_get_s_(ptr self__);
ptr SAT176_get_s_up_to_(ptr self__, char c0__);
void SAT176_unget_c_(ptr self__, char ch__);
ptr SAT176_b_(ptr self__, char bo__);
ptr SAT176_c_(ptr self__, char ch__);
ptr SAT176_i_(ptr self__, int in__);
ptr SAT176_s_(ptr self__, ptr st__);
ptr SAT176_r_(ptr self__, float re__);
ptr SAT176_d_(ptr self__, double do__);
ptr SAT176_nl_(ptr self__);
void SAT176_open_for_read_(ptr self__, ptr nm__);
void SAT176_open_for_write_(ptr self__, ptr nm__);
void SAT176_open_for_append_(ptr self__, ptr nm__);
void SAT176_close_(ptr self__);
ptr SAT176_get_s_of_len_(ptr self__, int n__);
void SAT176_flush_(ptr self__);
void SAT176_open_pipe_for_read_(ptr self__, ptr command__);
void SAT176_open_pipe_for_write_(ptr self__, ptr command__);
void SAT176_close_pipe_(ptr self__);
void SAT176_seek_relative_(ptr self__, int n__);
void SAT176_seek_from_front_(ptr self__, int n__);
void SAT176_seek_from_end_(ptr self__, int n__);
/*constant*/ ptr SAT176_source_files_kw_ = (ptr)(&gs1060_);
void SAT176_error_msg_(ptr self__, ptr s__);
void SAT176_error_exit_(ptr self__, ptr s__);
char SAT176_whitespace_(ptr self__, char ch__);
char SAT176_read_next_(ptr self__);
int SAT176_get_token_(ptr self__);
int SAT176_check_kw_(ptr self__);
ptr SAT176_curr_str_(ptr self__);
extern int attr_ent_SAT176[];

char SAT176_compile_key_p_(ptr self__, int i__)
{
   char res__ = S_char_VOID_;

   res__ = (char)((i__ <= 7) & (i__ >= 0));

   ret0__:
   return (res__);
}

ptr SAT176_initialize_(ptr self__, ptr initarg__)
{
   ptr res__ = 0;

   res__ = (ptr)self__;

   ret0__:
   return (res__);
}

int SAT176_error_(ptr self__)
{
   int res__ = S_int_VOID_;
   int    sv__ = S_int_VOID_;

   res__ = (int)SAT176_error_val_;
   SAT176_error_val_ = (int)0;
   if ((res__ == 0)) {
      sv__ = (int)scanf_val_();
      if ((sv__ == 0)) {
         res__ = (int)1;
      }
      else {
         if ((sv__ == -1)) {
            res__ = (int)2;
         }
         else {
         }
      }
   }
   else {
   }

   ret0__:
   return (res__);
}

ptr SAT176_create_(ptr self__, ptr nm__)
{
   ptr res__ = 0;
   SATHER_STR_(20,25,ls2248_,"ERROR: Failure to open \"");
   SATHER_STR_(20,3,ls632_,"\"\n");
   ptr gl4542_;

   gl4542_ = res__;
   res__ = (ptr)new_(176,0);
   SAT176_open_for_read_(res__,nm__);
   if ((SAT176_error_(res__) != 0)) {
      SAT176_error_exit_(self__,STR20_s_(STR20_s_(STR20_s_(STR20_create_(0),(ptr)(&ls2248_)),nm__),(ptr)(&ls632_)));
   }
   else {
   }
   IATT_(res__,16) = (int)1;
   PATT_(res__,20) = (ptr)STR70_create_(PATT_(res__,20),(- 1));

   ret0__:
   return (res__);
}

ptr SAT176_in_(ptr self__)
{
   ptr res__ = 0;
   SATHER_STR_(20,3,ls1310_,"in");
   ptr gl4543_;

   gl4543_ = res__;
   res__ = (ptr)new_(176,0);
   PATT_(res__,8) = (ptr)stdin_();
   PATT_(res__,12) = (ptr)(ptr)(&ls1310_);

   ret0__:
   return (res__);
}

ptr SAT176_out_(ptr self__)
{
   ptr res__ = 0;
   SATHER_STR_(20,4,ls1309_,"out");
   ptr gl4544_;

   gl4544_ = res__;
   res__ = (ptr)new_(176,0);
   PATT_(res__,8) = (ptr)stdout_();
   PATT_(res__,12) = (ptr)(ptr)(&ls1309_);

   ret0__:
   return (res__);
}

ptr SAT176_err_(ptr self__)
{
   ptr res__ = 0;
   SATHER_STR_(20,4,ls2561_,"err");
   ptr gl4545_;

   gl4545_ = res__;
   res__ = (ptr)new_(176,0);
   PATT_(res__,8) = (ptr)stderr_();
   PATT_(res__,12) = (ptr)(ptr)(&ls2561_);

   ret0__:
   return (res__);
}

char SAT176_check_eof_(ptr self__)
{
   char res__ = S_char_VOID_;

   res__ = (char)check_eof_(PATT_(self__,8));

   ret0__:
   return (res__);
}

char SAT176_get_c_(ptr self__)
{
   char res__ = S_char_VOID_;

   res__ = (char)INT15_to_c_(get_ci_(PATT_(self__,8)));

   ret0__:
   return (res__);
}

int SAT176_get_ci_(ptr self__)
{
   int res__ = S_int_VOID_;

   res__ = (int)get_ci_(PATT_(self__,8));

   ret0__:
   return (res__);
}

char SAT176_get_b_(ptr self__)
{
   char res__ = S_char_VOID_;
   int    ci__ = S_int_VOID_;
   char    c__ = S_char_VOID_;

   ci__ = (int)SAT176_get_ci_(self__);
   if ((ci__ == -1)) {
      SAT176_error_val_ = (int)2;
      goto ret0__;
   }
   else {
   }
   c__ = (char)INT15_to_c_(ci__);
   if ((c__ == 'T')) {
      res__ = (char)1;
   }
   else {
      if ((c__ == 'F')) {
      }
      else {
         SAT176_error_val_ = (int)1;
      }
   }

   ret0__:
   return (res__);
}

int SAT176_get_i_(ptr self__)
{
   int res__ = S_int_VOID_;

   res__ = (int)fscanfi_(PATT_(self__,8));

   ret0__:
   return (res__);
}

float SAT176_get_r_(ptr self__)
{
   float res__ = S_float_VOID_;

   res__ = (float)fscanfd_(PATT_(self__,8));

   ret0__:
   return (res__);
}

double SAT176_get_d_(ptr self__)
{
   double res__ = S_double_VOID_;

   res__ = (double)fscanfd_(PATT_(self__,8));

   ret0__:
   return (res__);
}

ptr SAT176_get_s_(ptr self__)
{
   ptr res__ = 0;
   int    ci__ = S_int_VOID_;
   int    ind__ = S_int_VOID_;
   char    c__ = S_char_VOID_;

   res__ = (ptr)STR20_create_(0);
   ci__ = (int)get_ci_(PATT_(self__,8));
   ind__ = S_int_VOID_;
   while (1) {
      if ((ci__ == -1)) {
         goto goto_tag_4546_;
      }
      else {
      }
      c__ = (char)INT15_to_c_(ci__);
      if (((ind__ + 1) == IATT_(res__,4))) {
         res__ = (ptr)STR20_c_(res__,c__);
      }
      else {
         CATT_(res__, 8 + ((ind__))) = (char)c__;
      }
      ind__ = (int)(ind__ + 1);
      if ((c__ == '\n')) {
         goto ret0__;
      }
      else {
      }
      ci__ = (int)get_ci_(PATT_(self__,8));
   }
goto_tag_4546_: ;

   ret0__:
   return (res__);
}

ptr SAT176_get_s_up_to_(ptr self__, char c0__)
{
   ptr res__ = 0;
   int    ci__ = S_int_VOID_;
   int    ind__ = S_int_VOID_;
   char    c__ = S_char_VOID_;

   res__ = (ptr)STR20_create_(0);
   ci__ = (int)get_ci_(PATT_(self__,8));
   ind__ = S_int_VOID_;
   while (1) {
      if ((ci__ == -1)) {
         goto goto_tag_4547_;
      }
      else {
      }
      c__ = (char)INT15_to_c_(ci__);
      if ((c__ == c0__)) {
         goto ret0__;
      }
      else {
      }
      if (((ind__ + 1) == IATT_(res__,4))) {
         res__ = (ptr)STR20_c_(res__,c__);
      }
      else {
         CATT_(res__, 8 + ((ind__))) = (char)c__;
      }
      ind__ = (int)(ind__ + 1);
      ci__ = (int)get_ci_(PATT_(self__,8));
   }
goto_tag_4547_: ;

   ret0__:
   return (res__);
}

void SAT176_unget_c_(ptr self__, char ch__)
{

   ungetc(ch__,PATT_(self__,8));

   ret0__:
   return;
}

ptr SAT176_b_(ptr self__, char bo__)
{
   ptr res__ = 0;

   if (bo__) {
      fputc('T',PATT_(self__,8));
   }
   else {
      fputc('F',PATT_(self__,8));
   }
   res__ = (ptr)self__;

   ret0__:
   return (res__);
}

ptr SAT176_c_(ptr self__, char ch__)
{
   ptr res__ = 0;

   fputc(ch__,PATT_(self__,8));
   res__ = (ptr)self__;

   ret0__:
   return (res__);
}

ptr SAT176_i_(ptr self__, int in__)
{
   ptr res__ = 0;

   fprintfi_(PATT_(self__,8),in__);
   res__ = (ptr)self__;

   ret0__:
   return (res__);
}

ptr SAT176_s_(ptr self__, ptr st__)
{
   ptr res__ = 0;

   fprintfs_(PATT_(self__,8),str_ptr_(st__));
   res__ = (ptr)self__;

   ret0__:
   return (res__);
}

ptr SAT176_r_(ptr self__, float re__)
{
   ptr res__ = 0;

   fprintfd_(PATT_(self__,8),re__);
   res__ = (ptr)self__;

   ret0__:
   return (res__);
}

ptr SAT176_d_(ptr self__, double do__)
{
   ptr res__ = 0;

   fprintfd_(PATT_(self__,8),do__);
   res__ = (ptr)self__;

   ret0__:
   return (res__);
}

ptr SAT176_nl_(ptr self__)
{
   ptr res__ = 0;

   res__ = (ptr)SAT176_c_(self__,'\n');

   ret0__:
   return (res__);
}

void SAT176_open_for_read_(ptr self__, ptr nm__)
{

   PATT_(self__,12) = (ptr)nm__;
   PATT_(self__,8) = (ptr)fopenr_(str_ptr_(nm__));
   if ((PATT_(self__,8) == 0)) {
      SAT176_error_val_ = (int)3;
   }
   else {
   }

   ret0__:
   return;
}

void SAT176_open_for_write_(ptr self__, ptr nm__)
{

   PATT_(self__,12) = (ptr)nm__;
   PATT_(self__,8) = (ptr)fopenw_(str_ptr_(nm__));
   if ((PATT_(self__,8) == 0)) {
      SAT176_error_val_ = (int)3;
   }
   else {
   }

   ret0__:
   return;
}

void SAT176_open_for_append_(ptr self__, ptr nm__)
{

   PATT_(self__,12) = (ptr)nm__;
   PATT_(self__,8) = (ptr)fopena_(str_ptr_(nm__));
   if ((PATT_(self__,8) == 0)) {
      SAT176_error_val_ = (int)3;
   }
   else {
   }

   ret0__:
   return;
}

void SAT176_close_(ptr self__)
{

   if ((PATT_(self__,8) != 0)) {
      fclose(PATT_(self__,8));
   }
   else {
   }

   ret0__:
   return;
}

ptr SAT176_get_s_of_len_(ptr self__, int n__)
{
   ptr res__ = 0;
   int    ci__ = S_int_VOID_;
   int    ind__ = S_int_VOID_;
   char    c__ = S_char_VOID_;

   res__ = (ptr)new1_(20,(n__ + 1),1);
   ci__ = (int)get_ci_(PATT_(self__,8));
   ind__ = S_int_VOID_;
   while (1) {
      if ((ci__ == -1)) {
         goto goto_tag_4548_;
      }
      else {
      }
      if ((ind__ >= n__)) {
         goto ret0__;
      }
      else {
      }
      c__ = (char)INT15_to_c_(ci__);
      CATT_(res__, 8 + ((ind__))) = (char)c__;
      ind__ = (int)(ind__ + 1);
   }
goto_tag_4548_: ;

   ret0__:
   return (res__);
}

void SAT176_flush_(ptr self__)
{

   if ((PATT_(self__,8) != 0)) {
      fflush(PATT_(self__,8));
   }
   else {
   }

   ret0__:
   return;
}

void SAT176_open_pipe_for_read_(ptr self__, ptr command__)
{

   PATT_(self__,8) = (ptr)popenr_(str_ptr_(command__));
   if ((PATT_(self__,8) == 0)) {
      SAT176_error_val_ = (int)3;
   }
   else {
   }

   ret0__:
   return;
}

void SAT176_open_pipe_for_write_(ptr self__, ptr command__)
{

   PATT_(self__,8) = (ptr)popenw_(str_ptr_(command__));
   if ((PATT_(self__,8) == 0)) {
      SAT176_error_val_ = (int)3;
   }
   else {
   }

   ret0__:
   return;
}

void SAT176_close_pipe_(ptr self__)
{

   if ((PATT_(self__,8) != 0)) {
      pclose(PATT_(self__,8));
   }
   else {
   }

   ret0__:
   return;
}

void SAT176_seek_relative_(ptr self__, int n__)
{

   if ((PATT_(self__,8) != 0)) {
      fseek(PATT_(self__,8),n__,1);
   }
   else {
   }

   ret0__:
   return;
}

void SAT176_seek_from_front_(ptr self__, int n__)
{

   if ((PATT_(self__,8) != 0)) {
      fseek(PATT_(self__,8),n__,0);
   }
   else {
   }

   ret0__:
   return;
}

void SAT176_seek_from_end_(ptr self__, int n__)
{

   if ((PATT_(self__,8) != 0)) {
      fseek(PATT_(self__,8),n__,2);
   }
   else {
   }

   ret0__:
   return;
}

void SAT176_error_msg_(ptr self__, ptr s__)
{

   error_msg(str_ptr_(s__));

   ret0__:
   return;
}

void SAT176_error_exit_(ptr self__, ptr s__)
{

   error_exit(str_ptr_(s__));

   ret0__:
   return;
}

char SAT176_whitespace_(ptr self__, char ch__)
{
   char res__ = S_char_VOID_;

   switch (ch__) {
      case (' ') :
         res__ = (char)1;
         break;
      case ('\n') :
         res__ = (char)1;
         break;
      case ('\b') :
         res__ = (char)1;
         break;
      case ('\t') :
         res__ = (char)1;
         break;
      default:
         res__ = (char)0;
         ;
   }

   ret0__:
   return (res__);
}

char SAT176_read_next_(ptr self__)
{
   char res__ = S_char_VOID_;

   CATT_(self__,4) = (char)SAT176_get_c_(self__);
   if ((CATT_(self__,4) == '\n')) {
      IATT_(self__,16) = (int)(IATT_(self__,16) + 1);
   }
   else {
   }
   res__ = (char)CATT_(self__,4);

   ret0__:
   return (res__);
}

int SAT176_get_token_(ptr self__)
{
   int res__ = S_int_VOID_;
   SATHER_STR_(20,48,ls2252_," (SAT_CMDFILE) : Unexpected end of quoted expr\n");

   while (1) {
      if (((! SAT176_whitespace_(self__,SAT176_read_next_(self__))) | SAT176_check_eof_(self__))) {
         goto goto_tag_4549_;
      }
      else {
      }
   }
goto_tag_4549_: ;
   if (SAT176_check_eof_(self__)) {
      res__ = (int)-1;
      goto ret0__;
   }
   else {
   }
   STR70_init_(PATT_(self__,20));
   if ((CATT_(self__,4) == '\"')) {
      res__ = (int)-3;
      while (1) {
         if (SAT176_check_eof_(self__)) {
            goto goto_tag_4550_;
         }
         else {
         }
         if ((SAT176_read_next_(self__) == '\\')) {
            if ((SAT176_read_next_(self__) == '\n')) {
               PATT_(self__,20) = (ptr)STR70_push_(STR70_push_(PATT_(self__,20),'\\'),CATT_(self__,4));
            }
            else {
               if ((! SAT176_check_eof_(self__))) {
                  PATT_(self__,20) = (ptr)STR70_push_(PATT_(self__,20),CATT_(self__,4));
               }
               else {
               }
            }
         }
         else {
            if ((CATT_(self__,4) == '\"')) {
               PATT_(self__,20) = (ptr)STR70_terminate_(PATT_(self__,20));
               goto ret0__;
            }
            else {
            }
            if ((! SAT176_check_eof_(self__))) {
               PATT_(self__,20) = (ptr)STR70_push_(PATT_(self__,20),CATT_(self__,4));
            }
            else {
            }
         }
      }
   goto_tag_4550_: ;
      if (SAT176_check_eof_(self__)) {
         SAT176_error_exit_(self__,STR20_s_(STR20_c_(STR20_i_(STR20_c_(STR20_s_(STR20_create_(0),PATT_(self__,12)),'('),IATT_(self__,16)),')'),(ptr)(&ls2252_)));
      }
      else {
      }
   }
   else {
   }
   if ((CATT_(self__,4) == '-')) {
      if ((SAT176_read_next_(self__) == '-')) {
         while (1) {
            if ((SAT176_read_next_(self__) == '\n')) {
               goto goto_tag_4551_;
            }
            else {
            }
            if (SAT176_check_eof_(self__)) {
               res__ = (int)-1;
               goto ret0__;
            }
            else {
            }
         }
      goto_tag_4551_: ;
         res__ = (int)SAT176_get_token_(self__);
         goto ret0__;
      }
      else {
         if ((! SAT176_check_eof_(self__))) {
            PATT_(self__,20) = (ptr)STR70_push_(PATT_(self__,20),'-');
            if ((! SAT176_whitespace_(self__,CATT_(self__,4)))) {
               PATT_(self__,20) = (ptr)STR70_push_(PATT_(self__,20),CATT_(self__,4));
            }
            else {
            }
            if (SAT176_whitespace_(self__,SAT176_read_next_(self__))) {
               PATT_(self__,20) = (ptr)STR70_terminate_(PATT_(self__,20));
               res__ = (int)-2;
               goto ret0__;
            }
            else {
               if (SAT176_check_eof_(self__)) {
                  PATT_(self__,20) = (ptr)STR70_terminate_(PATT_(self__,20));
                  res__ = (int)-2;
                  goto ret0__;
               }
               else {
               }
            }
         }
         else {
            PATT_(self__,20) = (ptr)STR70_terminate_(PATT_(self__,20));
            res__ = (int)-2;
            goto ret0__;
         }
      }
   }
   else {
   }
   PATT_(self__,20) = (ptr)STR70_push_(PATT_(self__,20),CATT_(self__,4));
   while (1) {
      if (SAT176_whitespace_(self__,SAT176_read_next_(self__))) {
         goto goto_tag_4552_;
      }
      else {
      }
      if (SAT176_check_eof_(self__)) {
         goto goto_tag_4552_;
      }
      else {
      }
      PATT_(self__,20) = (ptr)STR70_push_(PATT_(self__,20),CATT_(self__,4));
   }
goto_tag_4552_: ;
   PATT_(self__,20) = (ptr)STR70_terminate_(PATT_(self__,20));
   res__ = (int)SAT176_check_kw_(self__);
   if ((! SAT176_compile_key_p_(self__,res__))) {
      res__ = (int)-2;
   }
   else {
   }

   ret0__:
   return (res__);
}

int SAT176_check_kw_(ptr self__)
{
   int res__ = S_int_VOID_;

   if (STR70_is_equal_(PATT_(self__,20),(ptr)(&gs1060_))) {
      res__ = (int)0;
   }
   else {
      if (STR70_is_equal_(PATT_(self__,20),(ptr)(&gs1062_))) {
         res__ = (int)1;
      }
      else {
         if (STR70_is_equal_(PATT_(self__,20),(ptr)(&gs1064_))) {
            res__ = (int)2;
         }
         else {
            if (STR70_is_equal_(PATT_(self__,20),(ptr)(&gs1066_))) {
               res__ = (int)3;
            }
            else {
               if (STR70_is_equal_(PATT_(self__,20),(ptr)(&gs1068_))) {
                  res__ = (int)4;
               }
               else {
                  if (STR70_is_equal_(PATT_(self__,20),(ptr)(&gs1070_))) {
                     res__ = (int)5;
                  }
                  else {
                     if (STR70_is_equal_(PATT_(self__,20),(ptr)(&gs1072_))) {
                        res__ = (int)6;
                     }
                     else {
                        if (STR70_is_equal_(PATT_(self__,20),(ptr)(&gs1074_))) {
                           res__ = (int)7;
                        }
                        else {
                           res__ = (int)8;
                        }
                     }
                  }
               }
            }
         }
      }
   }

   ret0__:
   return (res__);
}

ptr SAT176_curr_str_(ptr self__)
{
   ptr res__ = 0;

   res__ = (ptr)STR70_strval_(PATT_(self__,20));

   ret0__:
   return (res__);
}

