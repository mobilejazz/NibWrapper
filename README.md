NibWrapper
==========

Nesting NIBs in other NIBs has never been that easy.

# How To

## 1. Nested Nib

1. Create a xib file and customize it as you want.
2. Optionally, create a subclass of UIView (the class name must be the same as the xib file).

![](https://raw.githubusercontent.com/mobilejazz/NibWrapper/master/README-images/Nib2.png)
![](https://raw.githubusercontent.com/mobilejazz/NibWrapper/master/README-images/Nib2-conf.png)


## 2. Parent Nib

1. In your parent nib, add a UIView and setup at as a `UINibWrapper` class. 

2. In the "User Defined Runtime Attributes" add an entry for the key *nibName* of type string and add the name of your custom view.

![](https://raw.githubusercontent.com/mobilejazz/NibWrapper/master/README-images/Nib1.png)
![](https://raw.githubusercontent.com/mobilejazz/NibWrapper/master/README-images/Nib1-conf.png)


## 3. Go!

Run your project and you are done!

![](https://raw.githubusercontent.com/mobilejazz/NibWrapper/master/README-images/Result.png)



