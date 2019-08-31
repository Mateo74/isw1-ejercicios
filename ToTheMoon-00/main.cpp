enum class TipoDeSuelo
{
	DuroYCompacto,
	BlandoYPoroso
};

class Suelo
{
public:
	Suelo(int dureza, int porosidad): dureza(dureza), porosidad(porosidad) {}

	int dureza() const {return dureza;}
	int porosidad() const {return porosidad;}
	
	TipoDeSuelo tipo() const
	{
		bool condicionDuro; // El valor de este booleano depende de alguna forma de la dureza y la porosidad.
		if (condicionDuro) {
			return DuroYCompacto;
		}
		else {
			return BlandoYPoroso;
		}
	}
	
private:
	int dureza;
	int porosidad;

};

enum class SentidoDeGiro
{
	SentidoHorario,
	SentidoAntihorario
};


class Brazo
{
public:
	void extraerMuestra(Suelo suelo)
	{
		if (suelo.tipo() == DuroYCompacto) {
			girarMecha(SentidoHorario, 150, 10);
			cerrarPinza();
			girarMecha(SentidoAntihorario, 150, 10);
		}
		else if (suelo.tipo() == BlandoYPoroso) {
			girarMecha(SentidoAntihorario, 100, 5);
			cerrarPinza();
			girarMecha(SentidoHorario, 100, 5);
		}
	}

private:
	void girarMecha(SentidoDeGiro sentido, int velocidad, int tiempo) {}
	void cerrarPinza() {}

};



int main() {
	return 0;
}
