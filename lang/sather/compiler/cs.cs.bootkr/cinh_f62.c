/* cinh_f62.c : Sather class: CINH_FEATOB, dbg=F, gc=T, chk=F */

#include "all_.h"
#include "c_names_.h"

static char __sather_compiled__;

extern ERR96_compiler_error_msg_();
extern int ERR96_out_of_line_err_info_();
extern ptr TYP114_pcopy_();
extern /*shared*/ int GLO68_curr_lineno_;
extern ptr CIN155_create_();
extern CIN155_mark_abstract_();
#include "macros_.h"



ptr CIN62_dup_();
CIN62_put_kwdname_();
ptr CIN62_sather_code_();
ptr CIN62_initialize_();
ptr CIN62_pcopy_();
/*constant*/ int CIN62_print_indent_ = 2;
ptr CIN62_create_();
CIN62_out_of_line_();
CIN62_mark_private_();
CIN62_mark_abstract_();
CIN62_mark_spec_();
CIN62_mark_shared_();
CIN62_mark_readonly_();
extern int attr_ent_CIN62[];

ptr CIN62_dup_(self__)
ptr self__;
{
   ptr res__ = 0;

   res__ = (ptr)copy_(self__,0);

   ret0__:
   return (res__);
}

CIN62_put_kwdname_(self__,nm__)
ptr self__;
int nm__;
{
   ptr gl912_;
   static int gl913_;
   static union dtype_ gl914_;
   ptr    x__ = 0;

   x__ = (ptr)self__;
   gl912_ = x__;
   cache_dispatch_(gl912_,796,gl913_,INTVAL_(gl914_));
   IATT_(gl912_,INTVAL_(gl914_)) = (int)nm__;

   ret0__:
   return;
}

ptr CIN62_sather_code_(self__)
ptr self__;
{
   ptr res__ = 0;


   ret0__:
   return (res__);
}

ptr CIN62_initialize_(self__,initarg__)
ptr self__;
ptr initarg__;
{
   ptr res__ = 0;

   res__ = (ptr)self__;

   ret0__:
   return (res__);
}

ptr CIN62_pcopy_(self__,pl__,pi__)
ptr self__;
ptr pl__;
ptr pi__;
{
   ptr res__ = 0;
   ptr gl915_;
   static int gl916_;
   static union dtype_ gl917_;
   ptr gl53_;

   gl915_ = PATT_(self__,28);
   cache_dispatch_(gl915_,407,gl916_,INTVAL_(gl917_));
   gl53_ = PFN_(gl917_)(gl915_,pl__,pi__);
   res__ = (ptr)CIN155_create_(res__,gl53_,IATT_(self__,20),PATT_(self__,12));
   if (CATT_(self__,4)) {
      CIN155_mark_abstract_(res__);
   }
   else {
   }

   ret0__:
   return (res__);
}

ptr CIN62_create_(self__,cls__)
ptr self__;
ptr cls__;
{
   ptr res__ = 0;
   SATHER_STR_(20,12,ls2098_,"CINH_FEATOB");
   SATHER_STR_(20,30,ls2099_,"Expected non-null type object");
   ptr gl918_;
   static int gl919_;
   static union dtype_ gl920_;
   int gl54_;

   if ((cls__ == 0)) {
      ERR96_compiler_error_msg_(0,(ptr)(&ls2098_),(ptr)(&ls2099_));
   }
   else {
   }
   res__ = (ptr)new_(62,0);
   PATT_(res__,28) = (ptr)cls__;
   IATT_(res__,20) = (int)GLO68_curr_lineno_;
   gl918_ = cls__;
   gl54_ = TYPE_(gl918_);
   if ((gl54_ == 56)) {
      CIN62_mark_abstract_(res__);
   }
   else {
   }

   ret0__:
   return (res__);
}

CIN62_out_of_line_(self__,fn__)
ptr self__;
ptr fn__;
{

   IATT_(self__,20) = (int)ERR96_out_of_line_err_info_(0,fn__,IATT_(self__,20));

   ret0__:
   return;
}

CIN62_mark_private_(self__)
ptr self__;
{

   CATT_(self__,5) = (char)1;

   ret0__:
   return;
}

CIN62_mark_abstract_(self__)
ptr self__;
{

   CATT_(self__,4) = (char)1;

   ret0__:
   return;
}

CIN62_mark_spec_(self__)
ptr self__;
{

   CATT_(self__,6) = (char)1;

   ret0__:
   return;
}

CIN62_mark_shared_(self__)
ptr self__;
{

   CATT_(self__,7) = (char)1;

   ret0__:
   return;
}

CIN62_mark_readonly_(self__)
ptr self__;
{

   CATT_(self__,8) = (char)1;

   ret0__:
   return;
}

