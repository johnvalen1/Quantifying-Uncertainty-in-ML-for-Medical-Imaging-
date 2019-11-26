from keras.models import Sequential
from keras.layers import Dense, Activation


batch_size = 256
num_classes = 2
epochs = 80
learning_rate = 0.00001


model = Sequential()
model.add(Conv2D(32, kernel_size=(3,3),
                 activation='relu',
                 input_shape=(50,50,3)))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Conv2D(64, (3,3), activation='relu'))
model.add(MaxPooling2D(pool_size=(2,2)))
model.add(Conv2D(128, (3, 3), activation='relu'))
model.add(Conv2D(256, (3, 3), activation='relu'))
model.add(Flatten()) #this converts our 3D feature maps to 1D feature vectors for the dense layer below
model.add(Dropout(0.5))
model.add(Dense(128, activation='relu'))
model.add(Dropout(0.5))
model.add(Dense(128, activation='relu'))
model.add(Dense(num_classes, activation='sigmoid'))

model.compile(loss=keras.losses.binary_crossentropy,
              optimizer=keras.optimizers.Adam(lr=learning_rate),
              metrics=['accuracy'])

early_stopping_monitor = EarlyStopping(monitor='val_loss', patience=3, mode='min')

model_checkpoint = ModelCheckpoint('best_model.h5', monitor='val_loss',
                                    mode='min', verbose=1, save_best_only=True)

training = model.fit_generator(datagen.flow(X_trainRosReshaped,Y_trainRosHot,
                                batch_size=batch_size),
                                steps_per_epoch=len(X_trainRosReshaped) / batch_size,
                                epochs=epochs,validation_data=(X_testRosReshaped, Y_testRosHot),
                                verbose=1, callbacks=[early_stopping_monitor, model_checkpoint])

from keras.models import load_model
from sklearn import metrics
model = load_model('best_model.h5')
y_pred_one_hot = model.predict(X_testRosReshaped)
y_pred_labels = np.argmax(y_pred_one_hot, axis = 1)
y_true_labels = np.argmax(Y_testRosHot,axis=1)

confusion_matrix = metrics.confusion_matrix(y_true=y_true_labels, y_pred=y_pred_labels)
