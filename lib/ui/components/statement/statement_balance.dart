import 'package:app_flutter_miban4/data/api/balance/balanceAPI.dart';
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatementBalance extends StatefulWidget {
  final int? balanceType;

  const StatementBalance({Key? key, this.balanceType}) : super(key: key);

  @override
  State<StatementBalance> createState() => _StatementBalanceState();
}

class _StatementBalanceState extends State<StatementBalance> {
  bool _isVisible = false;
  late String _balanceValue;
  late String _transational;
  late String _transationalValue;
  late Future<Balance> _balanceFuture; // Armazena o Future da API

  @override
  void initState() {
    super.initState();
    _balanceFuture = getBalance(); // Inicializa a busca da API apenas uma vez
  }

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Balance>(
      future: _balanceFuture, // Utiliza o Future armazenado
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingWidget();
        } else if (snapshot.hasError) {
          return _buildErrorWidget();
        } else if (snapshot.hasData) {
          Balance balance = snapshot.data!;
          _balanceValue = balance.balanceCents != "N/D"
              ? balance.balanceCents != null && balance.balanceCents != 0
              ? currencyFormat
              .format(double.parse(balance.balanceCents) / 100)
              : "0,00"
              : balance.balanceCents;
          _transationalValue = balance.transactionalValue;
          _transational = _transationalValue != "N/D"
              ? _transationalValue.isNotEmpty
              ? currencyFormat
              .format(double.parse(_transationalValue.toString()) / 100)
              : "0,00"
              : _transationalValue;

          return _buildBalanceWidget(snapshot.data!,
              widget.balanceType == 0 ? _balanceValue : _transational);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                child: Text(
                  widget.balanceType == 0
                      ? AppLocalizations.of(context)!.transfer_balance
                      : AppLocalizations.of(context)!.transfer_balance_savings,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'R\$',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          Positioned(
                            right: 0,
                            child: InkWell(
                              onTap: _toggleVisibility,
                              child: Icon(
                                _isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return const Center(
      child: Text(
        'Erro ao carregar o saldo.',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _buildBalanceWidget(Balance balance, String balanceValue) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                child: Text(
                  widget.balanceType == 0
                      ? AppLocalizations.of(context)!.transfer_balance
                      : AppLocalizations.of(context)!.transfer_balance_savings,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'R\$',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Text(
                            _isVisible ? balanceValue : '******',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Positioned(
                            right: 0,
                            child: InkWell(
                              onTap: _toggleVisibility,
                              child: Icon(
                                _isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}