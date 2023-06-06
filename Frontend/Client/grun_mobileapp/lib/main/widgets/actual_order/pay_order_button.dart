import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../../../menu/ui/menu_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/services/navigator_service.dart';
import '../../data/static_data/credit_card_data.dart';
import 'created_order_notification.dart';
import 'error_creating_order_notification.dart';

class PayButton extends StatelessWidget {
  const PayButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(
          minWidth: size.width * 0.2, maxWidth: size.width * 0.4),
      child: MaterialButton(
        height: size.height * 0.1,
        onPressed: () async {
          showDialog(
            context: context,
            builder: (_) => const SelectCreditCard(),
          );
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.borderRadius)),
        textColor: Colors.white,
        color: Constants.secondaryColor,
        child: AutoSizeText(Constants.payButtonText,
            minFontSize: size.width < 600 ? 16 : 28,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}

class SelectCreditCard extends StatelessWidget {
  const SelectCreditCard({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final isSelected = menuProvider.currentCreditCard != null;
    final size = MediaQuery.of(context).size;
    return AlertDialog(
        actions: [
          MaterialButton(
              onPressed: isSelected
                  ? () async {
                      final response = await menuProvider.finishOrder();
                      SchedulerBinding.instance
                          .addPostFrameCallback((timeStamp) {
                        _checkResponse(status: response, context: context);
                      });
                    }
                  : null,
              child: Text(
                Constants.selectCard,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: isSelected ? Constants.secondaryColor : Colors.grey),
              )),
          MaterialButton(
              onPressed: () {
                menuProvider.currentCreditCard = null;

                Navigator.pop(context);
              },
              child: Text(
                Constants.cancel,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Constants.secondaryColor),
              )),
        ],
        title: Text(
          Constants.selectCardTitle,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.black),
        ),
        content: SizedBox(
          height: size.height * 0.3,
          child: CarouselSlider.builder(
            itemCount: creditCards.length,
            options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              viewportFraction: 1,
              autoPlay: false,
              enableInfiniteScroll: false,
            ),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              final card = creditCards[index];
              return GestureDetector(
                  onTap: () {
                    menuProvider.changeCurrentCreditCard(card);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: menuProvider.currentCreditCard == card
                            ? Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 3,
                                strokeAlign: BorderSide.strokeAlignInside)
                            : null),
                    child: CreditCardWidget(
                      padding: 5,
                      isHolderNameVisible: true,
                      obscureCardCvv: false,
                      height: size.height,
                      width: size.width * 0.7,
                      cardHolderName: card.cardHolderName,
                      cardNumber: card.cardNumber,
                      cvvCode: card.cvv,
                      expiryDate: card.expiracyDate,
                      showBackView: false,
                      onCreditCardWidgetChange: (_) {},
                    ),
                  ));
            },
          ),
        ));
  }

  void _checkResponse({required int status, required BuildContext context}) {
    switch (status) {
      case 200:
        Navigator.pop(context);
        _showDialog(child: const CreatedOrderNotification());

        break;
      case 500:
        Navigator.pop(context);
        _showDialog(child: const ErrorCreatingOrderNotification());
        break;
      default:
    }
  }

  void _showDialog({required Widget child}) {
    showDialog(
        context: NavigatorService.navigatorKey.currentContext!,
        builder: (context) {
          return child;
        });
  }
}

/** final stripeService = StripeService();
          stripeService.init();
          stripeService.payWithCard(totalCost: (menuProvider.order.totalCost*100).toInt().toString(), currency: 'EUR', card: card)
           */
