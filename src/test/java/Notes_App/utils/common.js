function () {
   return {
      validateResponse : function (data) {
         if (data.responseCode !== undefined && data.responseCode !== 'NA' && data.responseCode !== '') {
            const currentStatusCode = data.responseCode;
            karate.log('We are currently about to validate ', currentStatusCode, ' status code');
            const actualStatusCode = karate.get('responseStatus').toString();
            if (currentStatusCode !== actualStatusCode) {
               karate.fail('The status code validation failed !!');
            } else {
               karate.log('Response status code validation passed')
            }
         }
         if (data.responseDescription !== undefined && data.responseDescription !== 'NA' && data.responseDescription !== '') {
            const currentResponseDescription = data.responseDescription;
            karate.log('We will now start to validate the response description...');
            const actualDescription = JSON.stringify(karate.get('response'));

            if (!actualDescription.includes(currentResponseDescription)) {
               karate.fail('Response description match failed !')
            } else {
               karate.log('Response description match passed...')
            }
         }
      }
   }
}