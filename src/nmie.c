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

void mexPrintComplex(complex z){
         mexPrintf("%f", z.r);
         double im;
         im = z.i;
         if(z.i > 0 || z.i == 0){
            mexPrintf("+%fi\n", z.i);
         }
         else{
            mexPrintf("%fi\n", z.i);
         }
}

void mexFunction( int nlhs, mxArray *plhs[], 
		  int nrhs, const mxArray*prhs[] )      
{
    int nmax, i;
    double L; 
    
    double *mr, *mi, *xptr, *lptr;
    double Qabs, Qbk, Qpr, g, albedo;
    int nTheta = 0;
    
    double *Qsca; 
    double *Qext; 
    
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
    
    //mexPrintf("%e \n",xptr[0]);
    
    //loop over L - scattnlay code is indexed from 1;
    for(i=0;i<L;i++){
        m[i+1].r = mr[i];
        m[i+1].i = mi[i];
        x[i+1] = xptr[i];
    }
    
    mexPrintf("x1 %e \n",x[1]);
    testx(x);
    
    mexPrintComplex(m[1]);
    testz(m);
    
    QSCA_OUT = mxCreateDoubleMatrix(sm, sn, mxREAL);
    QEXT_OUT = mxCreateDoubleMatrix(sm, sn, mxREAL);
    
    Qsca = mxGetPr(QSCA_OUT);
    Qext = mxGetPr(QEXT_OUT);
     
    nmax = nMie(L, x, m, nTheta, Theta, Qext, Qsca, &Qabs, &Qbk, &Qpr, &g, &albedo, S1, S2);
    return;
}




