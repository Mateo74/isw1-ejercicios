enum class TipoDeSuelo
{
	DuroYCompacto,
	BlandoYPoroso,
	Intermedio
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
		bool condicionBlando; // Lo mismo con este
		if (condicionDuro) {
			return DuroYCompacto;
		}
		else if (condicionBlando){
			return BlandoYPoroso;
		}
		else {
			return Intermedio;
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
		else if (suelo.tipo() == Intermedio) {
			girarMecha(SentidoHorario, 150, 5);
			cerrarPinza();
			girarMecha(sentidoAntihorario, 100, 10);
		}
	}

private:
	void girarMecha(SentidoDeGiro sentido, int velocidad, int tiempo) {}
	void cerrarPinza() {}

};



int main() {
	return 0;
}
