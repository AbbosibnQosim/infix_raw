<script src="{{asset('public/backEnd/')}}/js/main.js"></script>

{{ Form::open(['class' => 'form-horizontal', 'files' => true, 'route' => 'online_exam_question_edit',
                                'method' => 'POST', 'enctype' => 'multipart/form-data', 'id' => 'online_add_question_edit']) }}

    <input type="hidden" name="url" id="url" value="{{URL::to('/')}}">
    <input type="hidden" name="online_exam_id" value="{{$examId}}">
    <input type="hidden" name="id" value="{{$id}}">
    <input type="hidden" name="question_type" value="{{$type}}">
    <div class="white-box">
        <div class="add-visitor">
            <div class="common-fields" id="common-fields">

                <div class="row  mt-25">
                    <div class="col-lg-12">
                        <div class="input-effect">
                            <input class="primary-input form-control"
                                type="number" name="mark" autocomplete="off" value="{{ @$online_exam_question->mark}}" required>
                            <label>@lang('lang.marks')</label>
                            <span class="focus-border"></span>
                        </div>
                    </div>
                </div>
                <div class="row mt-25">
                    <div class="col-lg-12">
                        <div class="input-effect">
                            <textarea class="primary-input form-control" cols="0" rows="5" name="question_title" required>{{ @$online_exam_question->title}}</textarea>
                            <label>@lang('lang.question') @lang('lang.title')</label>
                            <span class="focus-border textarea"></span>
                        </div>
                    </div>
                </div>
            </div>
            @if($type == "M")
            @php
                $multiple_options = $online_exam_question->multipleOptions;
                $number_of_option = $online_exam_question->multipleOptions->count();
            @endphp
            <div class="multiple-choice" id="multiple-choice">
                
                <div class="row  mt-25">
                    <div class="col-lg-10">
                        <div class="input-effect">
                            <input class="primary-input form-control"
                                type="number" name="number_of_option" autocomplete="off" id="number_of_option_edit" value="{{ @$number_of_option}}">
                            <label>@lang('lang.number_options')</label>
                            <span class="focus-border"></span>
                        </div>
                    </div>
                    <div class="col-lg-2">
                        <button type="button" id="create-option-edit">@lang('lang.create')</button>
                    </div>
                </div>

            </div>

            <div class="multiple-options" id="multiple-options">
                @php $i=0; @endphp
                @foreach($multiple_options as $multiple_option)
                @php $i++; @endphp
                <div class='row  mt-25'>
                    <div class='col-lg-10'>
                        <div class='input-effect'>
                            <input class='primary-input form-control' type='text' name='option[]' autocomplete='off' required value="{{ @$multiple_option->title}}">
                            <label>@lang('lang.option') {{$i}}</label>
                            <span class='focus-border'></span>
                        </div>
                    </div>
                    <div class='col-lg-2'>
                        <button type='button'><input type='checkbox' name='option_check_{{$i}}' value='1' {{ @$multiple_option->status == 1? 'checked': ''}}></button>
                    </div>
                </div>
                @endforeach

            </div>
            @elseif($type == "T")
            <div class="true-false" id="true-false">
                <div class="row  mt-25">
                    <div class="col-lg-12 d-flex">
                        <p class="text-uppercase fw-500 mb-10"></p>
                        <div class="d-flex radio-btn-flex">
                            <div class="mr-30">
                                <input type="radio" name="trueOrFalse" id="relationFatherEdit" value="T" class="common-radio relationButton" {{ @$online_exam_question->trueFalse == 'T'? 'checked': ''}}>
                                <label for="relationFatherEdit">@lang('lang.true')</label>
                            </div>
                            <div class="mr-30">
                                <input type="radio" name="trueOrFalse" id="relationMotherEdit" value="F" class="common-radio relationButton" {{ @$online_exam_question->trueFalse == 'F'? 'checked': ''}}>
                                <label for="relationMotherEdit">@lang('lang.false')</label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            @else
            <div class="fill-in-the-blanks" id="fill-in-the-blanks">
                <div class="row  mt-25">
                    <div class="col-lg-12">
                        <div class="input-effect">
                            <textarea class="primary-input form-control" cols="0" rows="5" name="suitable_words" required>{{ @$online_exam_question->suitable_words}}</textarea>
                            <label>@lang('lang.suitable_words')</label>
                            <span class="focus-border textarea"></span>
                        </div>
                    </div>
                </div>
            </div>
            @endif
            <div class="row mt-40" id="submit-button">
                <div class="col-lg-12 text-center">
                    <button class="primary-btn fix-gr-bg">
                        <span class="ti-check"></span>
                        @lang('lang.update_online_exam_question')
                    </button>
                </div>
            </div>
        </div>
    </div>
{{ Form::close() }}



