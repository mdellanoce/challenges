#include <stdio.h>
#include <stdlib.h>

#define MAX 50

typedef unsigned long ulong;

typedef struct {
  int size;
  ulong data[MAX];
} vector;

typedef struct {
  int size;
  ulong data[MAX*MAX];
} matrix;

const ulong MOD = 1000000007;

void print_vector(vector* v)
{
  int i, s=v->size;
  ulong* d=v->data;
  for (i=0; i < s; ++i)
  {
    printf("%lu", d[i]);
    if (i < s-1)
    {
      printf(" ");
    }
  }
}

void copy_matrix(matrix* source, matrix* dest)
{
  int i,s=source->size*source->size;
  ulong *src=source->data,*dst=dest->data;
  for (i=0; i<s; ++i)
  {
    dst[i] = src[i];
  }
}

void init_companion_matrix(matrix* m)
{
  int r, c, i, s=m->size;
  ulong* d=m->data;
  for (r=0,i=0; r<s; ++r)
  {
    i = r*s;
    for (c=0; c<s; ++c)
    {
      if (r<s-1)
      {
        d[i+c] = c == r+1 ? 1 : 0;
      }
      else
      {
        d[i+c] = c > 1 && c < s-1 ? 0 : 1;
      }
    }
  }
}

void vector_matrix_multiply(vector* v, matrix* m, vector* result)
{
  int i,j,s=v->size,a;
  ulong *vd=v->data,*md=m->data,*r=result->data;

  //Make sure the result vector is zeroed out...
  for (i=0; i<s; ++i)
  {
    r[i] = 0;
  }

  for (i=0,a=0; i<s; ++i)
  {
    a = i*s;
    for (j=0; j<s; ++j)
    {
      r[i] = (r[i] + md[a+j] * vd[j]) % MOD;
    }
  }
}

void matrix_multiply(matrix* m1, matrix* m2, matrix* result)
{
  int i,j,k,s=m1->size,a;
  ulong *d1=m1->data,*d2=m2->data,*r=result->data;

  //Make sure the result matrix is zeroed out...
  for (i=0; i<s*s; ++i)
  {
    r[i] = 0;
  }

  for (i=0,a=0; i<s; ++i)
  {
    a = i*s;
    for (j=0; j<s; ++j)
    {
      for (k=0; k<s; ++k)
      {
        r[a+j] = (r[a+j] + d1[a+k] * d2[k*s+j]) % MOD;
      }
    }
  }
}

void matrix_pow(matrix* m, int p, matrix* result)
{
  int i;
  matrix w;
  w.size = m->size;
  copy_matrix(m, &w);
  if (p==1)
  {
    copy_matrix(&w, result);
  }
  else if(p%2==1)
  {
    matrix_pow(m, p-1, result);
    copy_matrix(result, &w);
    matrix_multiply(m, &w, result);
  }
  else
  {
    matrix_pow(m, p/2, result);
    copy_matrix(result, &w);
    matrix_multiply(&w, &w, result);
  }
}

void rotate_vector(vector* v, int amount, vector* result)
{
  int i,s=v->size,a;
  ulong *d=v->data,*r=result->data;
  for (i=0,a=s-amount; i<s; ++i,++a)
  {
    r[a%s] = d[i];
  }
}

int main()
{
  int test_cases, children, rounds, t, c, i;
  matrix companion,exponent;
  vector circle[MAX],result,rotate;

  scanf("%d", &test_cases);

  for (t=0; t<test_cases; ++t)
  {
    if (t > 0)
    {
      printf("\n");
    }

    scanf("%d %d", &children, &rounds);

    result.size = children;
    rotate.size = children;
    circle[0].size = children;
    companion.size = children;
    exponent.size = children;

    init_companion_matrix(&companion);
    matrix_pow(&companion, rounds, &exponent);

    for (c=0; c<children; ++c)
    {
      scanf("%lu", &circle[0].data[c]);
    }

    for (i=1; i<children; ++i)
    {
      circle[i].size = children;
      rotate_vector(&circle[i-1], 1, &circle[i]);
    }

    for (i=0; i<children; ++i)
    {
      vector_matrix_multiply(&circle[i], &exponent, &result);
      rotate_vector(&result, -((rounds%children)+i), &rotate);
      print_vector(&rotate);

      if (t < test_cases-1 || i < children-1)
      {
        printf("\n");
      }
    }
  }

  printf(" ");
}
