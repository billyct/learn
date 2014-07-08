Meteor.startup ->
    SimpleSchema.messages({
        required: "[label]是必须的",
        minString: "[label]必须至少[min]个字符",
        maxString: "[label]不能超过[max]个字符",
        minNumber: "[label]必须大于[min]",
        maxNumber: "[label]必须小于[max]",
        minDate: "[label]必须是或者在[min]之后",
        maxDate: "[label]必须在[max]之前",
        minCount: "必须至少[minCount]个值",
        maxCount: "必须不能超过[maxCount]个值",
        noDecimal: "[label]必须是数字",
        notAllowed: "[value]不是一个允许的值",
        expectedString: "[label]必须是字符串",
        expectedNumber: "[label]必须是数字",
        expectedBoolean: "[label]必须是布尔值",
        expectedArray: "[label]必须是一个数组",
        expectedObject: "[label]必须是一个对象",
        expectedConstructor: "[label]必须是[type]",
        regEx: "[label]正则匹配失败",
        notUnique : "该[label]已被创建"
    });
