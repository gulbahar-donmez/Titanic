train <- read.csv("C:/Users/Gulbahar-NB/Downloads/titanic/train.csv")

test<-read.csv("C:/Users/Gulbahar-NB/Downloads/titanic/test.csv")

#test ve traini birleştiriyoruz
test$Survived=NA

veri<=rbind(train,test)

ncol(train)
ncol(test)

str(veri)
#paket yüklü değilse -->install.packages("dplyr")

#dönüşümleri yaptık.
veri<-veri %>% mutate(Survived=factor(Survived),
                      Pclass=factor(Pclass),
                      Cabin=as.character(Cabin),  
                      Ticket=as.character(Ticket))



p1<-ggplot(veri[1:891,]) +geom_bar(mapping = aes(x=Pclass,fill=Survived),position = "fill")

#yaşa göre hayatta kalıp kalmamalarına göre ayırdık 
p2<-ggplot(veri[1:891,]) +geom_freqpoly(mapping = aes(x=Age,color=Survived),bins =50) +theme(legend.position ="none") 
#bilet fiyatlarına göre hayatta kalıp kalmama durumunu inceliyoruz
p3<-ggplot(veri[1:891,]) +geom_freqpoly(mapping = aes(x=Fare,color=Survived),bins =50)+theme(legend.position ="none")
#aileyle gitmek veya yalnız gitmenin hayatta kalmaya etkisi
p4<-ggplot(veri[1:891,]) +geom_bar(mapping = aes(x=SibSp +Parch,fill=Survived),position = "fill")+theme(legend.position ="none")


ggplot2.multiplot(p1,p2,p3,p4)

#NA DEĞERLERİN DOLDURMA
sum(is.na(veri$Age))
#her sütunda kaçar tane na var
apply(veri, 2, function(x) sum(is.na(x)))


mean(veri[!is.na(veri$Age),]$Age)

median(veri[!is.na(veri$Age),]$Age)

#kişilerin unvanlarından yola çıkarak gruplayarak seçim yapailiriz.
#yukarıdaki mean,median kullanırsak 8 yaşındaki çocuğunda yaşını 28-29 gireceğiz bu da algoritmayı yanıltacaktır.
 
#regular expression 
Unvan<-sub(".*,.([^.]*)\\..*","\\1",veri$Name)

#unvan adında yeni bir sütun oluşturduk
veri$Unvan<-Unvan
#unvanları gruplama
str(veri)
#unvan verisini karakter yapısından faktör yapısına dönüştürdük
veri<- veri %>% mutate(Unvan=factor(Unvan))

levels(veri$Unvan)

#levels sayısını azaltmak için fct_collapse() kullanılır


#seviyeleri manipüle ettik
veri=veri %>% mutate(Unvan=fct_collapse(Unvan,
             "Miss"=c("Mile","MS"),"Mrs"="Mme",
             "Ranked"=c("Major","Dr","Capt","Col","Rev"),
             "Royalty"=c("Lady","Dona","the Countess","Don","Sir","Jonkheer")))




ggplot(veri[1:891,])+ geom_bar(mapping=aes(x=Unvan,fill=Survived),Position="fill")


#bulundukları Unvan grubuna göre yaşların ortalamasını alıp NA değerlerini dolduralım.
veri=veri %>% group_by(Unvan) %>% 
mutate(Age=ifelse(is.na(Age),round(median(Age,na.rm=T),1),Age))


#kabinleri biliniyor mu bilinmiyor mu

kabin <- ifelse(veri$Cabin == "", FALSE, TRUE)

#kabinlerin bilinip bilinmemesiyle bir sütun olşturduk(T,F) döndürüyor

veri$kabin=kabin

ggplot(veri[1:891,]) +geom_bar(mapping=aes(x=kabin,fill=Survived),Position="fill")


#kabin numarası bilinen insanların %60'dan daha fazlası kurtulmuş.
#bu da demek oluyor ki kabinleri bilinmeyen insanların bilgileri üzerinde çok fazla durulmamış.


veri %>% filter(is.na(Fare))


#fare'daki na değerlerini doldurduk
Fare=ifelse(is.na(veri$Fare),round(median(veri$Fare,na.rm=T),1),veri$Fare)

veri$Fare=Fare

train=veri[1:891,]

#test data frameindeki insanların hayatta kalıp kalmama durumlarını öğrenmek istiyoruz bunun için de bir algoritma eğiteceğiz

train1=train[1:710,]
test1=train[711:891,]

#random forest yüklü değilse --> install.packages("randomForest")

Rf=randomForest(Survived~Pclass+Sex+Age+SibSp+Parch+Fare+kabin,data=train1,mtyr=3,ntree=1000)

tahminler=predict(Rf, test1[,c(3,5,6,7,8,10,14)])

#karşılaştırma yapalım
table(tahminler,test1$Survived)
# %86 doğruluk oranı var
sum(test1$Survived==0) #hayatta kalmayanların gerçek değeri
sum(test1$Survived==1) #hayatta kalanların gerçek değeri

test=veri[892:1309,]

#test verisetindekini tahmin edelim
tahminler1=predict(Rf, test[,c(3,5,6,7,8,10,14)])

length(tahminler1)


sonuc=test$PassengerId
sonuc=as.data.frame(sonuc)
colnames(sonuc)=c("PassengerId")
sonuc$Survived=tahminler1

getwd()
setwd("C:/Users/Gulbahar-NB/Desktop")
write.csv(sonuc,"sonuc.csv",row.names = F)






















