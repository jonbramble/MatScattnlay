// write the mex function for nmie
#include "mex.h"
#include "ucomplex.h"
#include "nmiec.h"

#define MAXLAYERS 110
#define MAXTHETA 80

/* Input Arguments */

#define	L_IN	prhs[0]
#define	X_IN	prhs[1]
#define	M_IN	prhs[2]

/* Output Arguments */

#define	QEXT_OUT	plhs[0]
#define	QSCA_OUT	plhs[1]


void mexFunction( int nlhs, mxArray *plhs[], 
		  int nrhs, const mxArray*prhs[] )      
{
    int nmax, i;
    double L; 
    
    double *mr, *mi, *xptr, *lptr;
    double Qext, Qsca, Qabs, Qbk, Qpr, g, albedo;
    int nTheta = 0;
    
    double *Qsca_p; 
    double *Qext_p; 
    
    complex m[MAXLAYERS];
    double x[MAXLAYERS];
    double Theta[MAXTHETA];
    complex S1[MAXLAYERS];
    complex S2[MAXLAYERS];
   
    mwSize sm = mxGetM(M_IN);
    mwSize sn = mxGetN(M_IN);
    //mexPrintf("%i ",sm);
    //mexPrintf("%i \n",sn);
    
    mr = mxGetPr(M_IN);
    mi = mxGetPi(M_IN);
    
    lptr = mxGetPr(L_IN); 
    xptr = mxGetPr(X_IN);
    
    L = lptr[0];
    
    //loop over L - scattnlay code is indexed from 1;
    for(i=0;i<L;i++){
        m[i+1].r = mr[i];
        m[i+1].i = mi[i];
        x[i+1] = xptr[i];
    }

    QSCA_OUT = mxCreateDoubleMatrix(sm, sn, mxREAL);
    QEXT_OUT = mxCreateDoubleMatrix(sm, sn, mxREAL);
    
    Qsca_p = mxGetPr(QSCA_OUT);
    Qext_p = mxGetPr(QEXT_OUT);
   
    nmax = nMie(L, x, m, nTheta, Theta, Qext_p, Qsca_p, &Qabs, &Qbk, &Qpr, &g, &albedo, S1, S2);
    return;
}
