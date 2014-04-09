//
//  ViewController.m
//  pbt
//
//  Created by robi on 07.04.14.
//  Copyright (c) 2014 Mobilesoft365. All rights reserved.
//

#import "ViewController.h"
#import <AddressBook/AddressBook.h>
#import "utils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // verify access
    ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
    NSLog(@"auth status %@",ABAuthorizationStatusToString(authorizationStatus));
    
    CFErrorRef errorAB = NULL;
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &errorAB);
    if (errorAB) {
        // parse rrror codes
        NSLog(@"An error occur when try to access address book : %@", errorAB);
    }
    
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if (!granted) {
            NSLog(@"not granted");
        }
    });
    
    if (authorizationStatus == kABAuthorizationStatusAuthorized) {
        CFIndex personsCount = ABAddressBookGetPersonCount(addressBook);
        NSLog(@"number of persons in address book : %ld", (long)personsCount);
        
        CFArrayRef arrayOfPersons = ABAddressBookCopyArrayOfAllPeople(addressBook);
        CFIndex arrayCount = CFArrayGetCount(arrayOfPersons);
        for (CFIndex i=0; i<arrayCount; ++i) {
            ABRecordRef aPerson = CFArrayGetValueAtIndex(arrayOfPersons, i);
            if (ABRecordGetRecordType(aPerson) == kABPersonType) {
                CFStringRef personFirstName = ABRecordCopyValue(aPerson, kABPersonFirstNameProperty);
                CFStringRef personLastName = ABRecordCopyValue(aPerson, kABPersonLastNameProperty);
                CFStringRef personPrefix = ABRecordCopyValue(aPerson, kABPersonPrefixProperty);
                CFStringRef personSuffics = ABRecordCopyValue(aPerson, kABPersonSuffixProperty);
                CFStringRef personNickName = ABRecordCopyValue(aPerson, kABPersonNicknameProperty);
                CFStringRef personPhoneticFirstname = ABRecordCopyValue(aPerson, kABPersonFirstNamePhoneticProperty);
                CFStringRef personPhoneticLastname = ABRecordCopyValue(aPerson, kABPersonLastNamePhoneticProperty);
                CFStringRef personPhoneticMiddlename = ABRecordCopyValue(aPerson, kABPersonMiddleNamePhoneticProperty);
                CFStringRef personOrganization = ABRecordCopyValue(aPerson, kABPersonOrganizationProperty);
                CFStringRef personJobTitle = ABRecordCopyValue(aPerson, kABPersonJobTitleProperty);
                CFStringRef personDepartmant = ABRecordCopyValue(aPerson, kABPersonDepartmentProperty);
                ABMultiValueRef personEmails = ABRecordCopyValue(aPerson, kABPersonEmailProperty);
                CFDateRef personBirthDate = ABRecordCopyValue(aPerson, kABPersonBirthdayProperty);
                CFStringRef personNote = ABRecordCopyValue(aPerson, kABPersonNoteProperty);
                ABMultiValueRef personPhones = ABRecordCopyValue(aPerson, kABPersonPhoneProperty);
                ABMultiValueRef personAddress = ABRecordCopyValue(aPerson, kABPersonAddressProperty);
                ABMultiValueRef personInstantMessage = ABRecordCopyValue(aPerson, kABPersonInstantMessageProperty);
                ABMultiValueRef personSocialProfile = ABRecordCopyValue(aPerson, kABPersonSocialProfileProperty);
                ABMultiValueRef personURL = ABRecordCopyValue(aPerson, kABPersonURLProperty);
                ABMultiValueRef personRelatedNames = ABRecordCopyValue(aPerson, kABPersonRelatedNamesProperty);
                
                bool hasImgData = ABPersonHasImageData(aPerson);
                if (hasImgData) {
                    NSLog(@"this person has img data");
                }
                else {
                    NSLog(@"This person has not img data");
                }
                
                CFIndex numberOfPhoneRecords = ABMultiValueGetCount(personPhones);
                for (CFIndex i=0; i<numberOfPhoneRecords; ++i) {
                    CFStringRef label = ABMultiValueCopyLabelAtIndex(personPhones, i);
                    CFStringRef phoneNumber = ABMultiValueCopyValueAtIndex(personPhones, i);
                    NSLog(@"%@ : %@", label, phoneNumber);
                }
                
                CFIndex numberOfEmails = ABMultiValueGetCount(personEmails);
                for (CFIndex i=0; i<numberOfEmails; ++i) {
                    CFStringRef label = ABMultiValueCopyLabelAtIndex(personEmails, i);
                    CFStringRef email = ABMultiValueCopyValueAtIndex(personEmails, i);
                    NSLog(@"%@ : %@", label, email);
                }
                
                CFIndex addressCount = ABMultiValueGetCount(personAddress);
                for (CFIndex i=0; i<addressCount; ++i) {
                    CFStringRef label = ABMultiValueCopyLabelAtIndex(personAddress, i);
                    CFStringRef email = ABMultiValueCopyValueAtIndex(personAddress, i);
                    NSLog(@"%@ : %@", label, email);
                }
                
                CFIndex instantMessageCount = ABMultiValueGetCount(personInstantMessage);
                for (CFIndex i=0; i<instantMessageCount; ++i) {
                    CFStringRef label = ABMultiValueCopyLabelAtIndex(personInstantMessage, i);
                    CFStringRef email = ABMultiValueCopyValueAtIndex(personInstantMessage, i);
                    NSLog(@"%@ : %@", label, email);
                }
                
                NSLog(@"Social profile");
                CFIndex socialProfileCount = ABMultiValueGetCount(personSocialProfile);
                for (CFIndex i=0; i<socialProfileCount; ++i) {
                    CFStringRef label = ABMultiValueCopyLabelAtIndex(personSocialProfile, i);
                    CFStringRef email = ABMultiValueCopyValueAtIndex(personSocialProfile, i);
                    NSLog(@"%@ : %@", label, email);
                }
                
                NSLog(@"Person URL");
                CFIndex urlCount = ABMultiValueGetCount(personURL);
                for (CFIndex i=0; i<urlCount; ++i) {
                    CFStringRef key = ABMultiValueCopyLabelAtIndex(personURL, i);
                    CFStringRef value = ABMultiValueCopyValueAtIndex(personURL, i);
                    NSLog(@"%@ : %@", key, value);
                }
               
                
                NSLog(@"Person related names");
                CFIndex relatedCount = ABMultiValueGetCount(personRelatedNames);
                for (CFIndex i=0; i<relatedCount; ++i) {
                    CFStringRef key = ABMultiValueCopyLabelAtIndex(personRelatedNames, i);
                    CFStringRef value = ABMultiValueCopyValueAtIndex(personRelatedNames, i);
                    NSLog(@"%@ : %@", key, value);
                }
                
                NSLog(@"Name : %@ %@ %@ %@",personPrefix, personFirstName, personLastName, personSuffics);
                NSLog(@"Nickname : %@", personNickName);
                NSLog(@"phonetic First Name : %@", personPhoneticFirstname);
                NSLog(@"phonetic Last Name : %@", personPhoneticLastname);
                NSLog(@"phonetic middle name : %@", personPhoneticMiddlename);
                NSLog(@"person organization : %@", personOrganization);
                NSLog(@"person job title : %@", personJobTitle);
                NSLog(@"person departmant : %@", personDepartmant);
                NSLog(@"person birth date : %@", personBirthDate);
                NSLog(@"person note : '%@'", personNote);
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
