#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#define MY_CXT_KEY "Experimental::Signatures::EnhancedWarnings::_guts" XS_VERSION

typedef struct {
    OP *(*Perl_pp_die_orig)(pTHX);
    SV *err1;
    SV *err2;
    SV *err3;
} my_cxt_t;

START_MY_CXT

OP * my_perl_pp_die(pTHX) {
    dMY_CXT;

    if (
          cLISTOP->op_first && cLISTOP->op_first->op_type == OP_PUSHMARK
       && cLISTOP->op_last && cLISTOP->op_last->op_type == OP_CONST
    ) {
        SV *sv = cSVOPx(cLISTOP->op_last)->op_sv;

        if (sv_eq(sv, MY_CXT.err1) || sv_eq(sv, MY_CXT.err2) || sv_eq(sv, MY_CXT.err3)) {
            const PERL_CONTEXT *cx = NULL;
            const PERL_CONTEXT *dbcx = NULL;

            cx = caller_cx(0+!!(PL_op->op_private & OPpOFFBYONE), &dbcx);

            if (cx) {
                const COP *lcop;

                lcop = (COP*) Perl_closest_cop(cx->blk_oldcop, cx->blk_oldcop->op_sibling,
                    cx->blk_sub.retop, TRUE);

                if (!lcop) {
                        lcop = cx->blk_oldcop;
	        }

                PL_curcop = (COP*)lcop;
            }
        }
    }

    return MY_CXT.Perl_pp_die_orig(aTHX);
}

MODULE = Experimental::Signatures::EnhancedWarnings		PACKAGE = Experimental::Signatures::EnhancedWarnings		

BOOT:
    dMY_CXT;

    MY_CXT.err1 = newSVpvs("Too few arguments for subroutine");
    MY_CXT.err2 = newSVpvs("Too many arguments for subroutine");
    MY_CXT.err3 = newSVpvs("Odd name/value argument for subroutine");
    MY_CXT.Perl_pp_die_orig = PL_ppaddr[OP_DIE];
    PL_ppaddr[OP_DIE] = my_perl_pp_die;
