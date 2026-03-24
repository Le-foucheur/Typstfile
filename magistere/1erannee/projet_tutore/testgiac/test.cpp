#include <giac/config.h>
#include <giac/giac.h>
using namespace std;
using namespace giac;

int main()
{
    context ct;
    gen e("x^2-1", &ct);
    e = eval(e, 1, &ct);
    cout << _factor(e, &ct) << endl;
}
